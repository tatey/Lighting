import Cocoa
import NotificationCenter

class TodayViewController: NSViewController, NCWidgetProviding {
	@IBOutlet var lightTargetCollectionView: NSCollectionView?

    override var nibName: String? {
        return "TodayViewController"
    }

	override func viewDidLoad() {
		super.viewDidLoad()

		self.lightTargetCollectionView?.backgroundColors = [NSColor.clearColor()]
		self.lightTargetCollectionView?.content = ["Test 0", "Test 1", "Test 2"]
	}

	// MARK: NCWidgetProviding
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)!) {
        completionHandler(.NoData)
    }
}
