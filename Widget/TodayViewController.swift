import Cocoa
import NotificationCenter
import LIFXHTTPKit

class TodayViewController: NSViewController, NCWidgetProviding {
	@IBOutlet weak var lightTargetCollectionView: LightTargetCollectionView?

	var client: Client!
	var lights: LightTarget!

    override var nibName: String? {
        return "TodayViewController"
    }

	override func viewDidLoad() {
		super.viewDidLoad()

		client = Client(accessToken: "")
		lights = client.allLightTarget()
		lightTargetCollectionView?.backgroundColors = [NSColor.clearColor()]
	}

	override func viewWillLayout() {
		super.viewWillLayout()

		if let lightTargetCollectionView = self.lightTargetCollectionView {
			let sizeThatFits = lightTargetCollectionView.sizeThatFits(NSSize(width: view.frame.width, height: CGFloat.max))
			preferredContentSize = NSSize(width: view.frame.width, height: sizeThatFits.height)
		}
	}

	private func getLightTargetsSortedByLabel() -> [LightTarget] {
		return self.lights.toLightTargets().sorted { (lhs, rhs) in
			return lhs.label < rhs.label
		}
	}

	// MARK: NCWidgetProviding

    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)!) {
		client.fetch { [unowned self] (error) in
			if error != nil {
				completionHandler(.Failed)
				return
			}

			self.lightTargetCollectionView?.content = self.getLightTargetsSortedByLabel()
			self.view.needsLayout = true
			completionHandler(.NewData)
		}
    }

	func widgetMarginInsetsForProposedMarginInsets(defaultMarginInset: NSEdgeInsets) -> NSEdgeInsets {
		return NSEdgeInsets(top: defaultMarginInset.top, left: 0, bottom: defaultMarginInset.bottom, right: 0)
	}
}
