import Cocoa
import NotificationCenter

class TodayViewController: NSViewController, NCWidgetProviding {
	var lightTargetManager: LightTargetManager?

	@IBOutlet var lightTargetCollectionView: NSCollectionView?

    override var nibName: String? {
        return "TodayViewController"
    }

	override func viewDidLoad() {
		super.viewDidLoad()

		self.lightTargetManager = LightTargetManager()
		self.lightTargetCollectionView?.backgroundColors = [NSColor.clearColor()]
	}

	// MARK: NCWidgetProviding
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)!) {
		self.lightTargetManager?.update({ () -> Void in
			if let lightTargets = self.lightTargetManager?.lightTargets {
				self.lightTargetCollectionView?.content = lightTargets.map({ (lightTarget: LightTarget) -> String in
					lightTarget.label
				})
				completionHandler(.NewData)
			} else {
				completionHandler(.NoData)
			}
		}, failure: { () -> Void in
			completionHandler(.Failed)
		})
    }
}
