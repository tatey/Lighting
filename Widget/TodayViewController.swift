import Cocoa
import NotificationCenter
import LIFXHTTPKit

class TodayViewController: NSViewController, NCWidgetProviding {
	static let DefaultMargin: CGFloat = 5.0 // Derived from margin between collection view and label in TodayViewController.xib
	static let EmptyString: String = ""

	@IBOutlet weak var lightsCollectionView: LightTargetCollectionView?
	@IBOutlet weak var errorLabel: NSTextField?

	var accessToken: AccessToken!
	var client: Client!
	var allLightTarget: LightTarget!

    override var nibName: String? {
        return "TodayViewController"
    }

	override func viewDidLoad() {
		super.viewDidLoad()

		accessToken = AccessToken()
		client = Client(accessToken: accessToken.token ?? TodayViewController.EmptyString)
		allLightTarget = client.allLightTarget()

		accessToken.addObserver {
			self.client = Client(accessToken: self.accessToken.token ?? TodayViewController.EmptyString)
			self.lightsCollectionView?.content = self.lightTargetsBySortingAlphabetically(self.allLightTarget)
			self.setNeedsUpdate()
		}

		lightsCollectionView?.backgroundColors = [NSColor.clearColor()]
	}

	private func lightTargetsBySortingAlphabetically(lightTarget: LightTarget) -> [LightTarget] {
		return [lightTarget] + lightTarget.toLightTargets().sorted { (lhs, rhs) in
			return lhs.label < rhs.label
		}
	}

	private func setNeedsUpdate() {
		if let lightsCollectionView = self.lightsCollectionView, errorLabel = self.errorLabel {
			var newSize = lightsCollectionView.sizeThatFits(NSSize(width: view.frame.width, height: CGFloat.max))

			if errorLabel.stringValue == TodayViewController.EmptyString {
				errorLabel.frame = CGRectZero
			} else {
				errorLabel.sizeToFit()
			}
			newSize.height += errorLabel.frame.height

			preferredContentSize = NSSize(width: view.frame.width, height: newSize.height + TodayViewController.DefaultMargin)
		}
	}

	// MARK: NCWidgetProviding

    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)!) {
		client.fetch { (error) in
			dispatch_async(dispatch_get_main_queue()) {
				if error != nil {
					self.errorLabel?.stringValue = "An error occured fetching lights."
					completionHandler(.Failed)
				} else {
					self.errorLabel?.stringValue = TodayViewController.EmptyString
					self.lightsCollectionView?.content = self.lightTargetsBySortingAlphabetically(self.allLightTarget)
					completionHandler(.NewData)
				}

				self.setNeedsUpdate()
			}
		}
    }

	func widgetMarginInsetsForProposedMarginInsets(defaultMarginInset: NSEdgeInsets) -> NSEdgeInsets {
		return NSEdgeInsets(top: defaultMarginInset.top + TodayViewController.DefaultMargin, left: defaultMarginInset.left - 20.0, bottom: defaultMarginInset.bottom, right: 0.0)
	}
}
