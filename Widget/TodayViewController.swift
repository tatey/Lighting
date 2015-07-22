import Cocoa
import NotificationCenter
import LIFXHTTPKit

class TodayViewController: NSViewController, NCWidgetProviding {
	@IBOutlet weak var lightTargetCollectionView: LightTargetCollectionView?

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
			self.updateLightTargetCollectionView()
		}

		lightTargetCollectionView?.backgroundColors = [NSColor.clearColor()]
	}

	private func updateLightTargetCollectionView() {
		lightTargetCollectionView?.content = [lights] + lights.toLightTargets().sorted { (lhs, rhs) in
			return lhs.label < rhs.label
		}

		if let lightTargetCollectionView = self.lightTargetCollectionView {
			let sizeThatFits = lightTargetCollectionView.sizeThatFits(NSSize(width: view.frame.width, height: CGFloat.max))
			preferredContentSize = NSSize(width: view.frame.width, height: sizeThatFits.height)
		}
	}

	// MARK: NCWidgetProviding

    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)!) {
		client.fetch { (error) in
			dispatch_async(dispatch_get_main_queue()) {
				if error != nil {
					completionHandler(.Failed)
					return
				}

				self.updateLightTargetCollectionView()
				completionHandler(.NewData)
			}
		}
    }

	func widgetMarginInsetsForProposedMarginInsets(defaultMarginInset: NSEdgeInsets) -> NSEdgeInsets {
		return NSEdgeInsets(top: defaultMarginInset.top + 3.0, left: defaultMarginInset.left - 20.0, bottom: 0.0, right: 0.0)
	}
}
