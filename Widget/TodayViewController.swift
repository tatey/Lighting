import Cocoa
import NotificationCenter
import LIFXHTTPKit

class TodayViewController: NSViewController, NCWidgetProviding {
	@IBOutlet weak var lightsCollectionView: LightTargetCollectionView?
	@IBOutlet weak var errorLabel: NSTextField?

	var accessToken: AccessToken!
	var client: Client!
	var lights: LightTarget!

    override var nibName: String? {
        return "TodayViewController"
    }

	override func viewDidLoad() {
		super.viewDidLoad()

		accessToken = AccessToken()
		client = Client(accessToken: accessToken.token ?? "")
		lights = client.allLightTarget()

		accessToken.addObserver {
			self.client = Client(accessToken: self.accessToken.token ?? "")
			self.lightsCollectionView?.content = [self.lights] + self.lights.toLightTargets().sorted { (lhs, rhs) in
				return lhs.label < rhs.label
			}
			self.setNeedsUpdate()
		}

		lightsCollectionView?.backgroundColors = [NSColor.clearColor()]
	}

	private func setNeedsUpdate() {
		if let lightsCollectionView = self.lightsCollectionView, errorLabel = self.errorLabel {
			var newSize = lightsCollectionView.sizeThatFits(NSSize(width: view.frame.width, height: CGFloat.max))

			if errorLabel.stringValue == "" {
				errorLabel.frame = CGRectZero
			} else {
				errorLabel.sizeToFit()
			}
			newSize.height += errorLabel.frame.height

			preferredContentSize = NSSize(width: view.frame.width, height: newSize.height + 5.0)
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
					self.errorLabel?.stringValue = ""
					self.lightsCollectionView?.content = [self.lights] + self.lights.toLightTargets().sorted { (lhs, rhs) in
						return lhs.label < rhs.label
					}
					completionHandler(.NewData)
				}

				self.setNeedsUpdate()
			}
		}
    }

	func widgetMarginInsetsForProposedMarginInsets(defaultMarginInset: NSEdgeInsets) -> NSEdgeInsets {
		return NSEdgeInsets(top: defaultMarginInset.top + 3.0, left: defaultMarginInset.left - 20.0, bottom: defaultMarginInset.bottom, right: 0.0)
	}
}
