import Cocoa
import NotificationCenter
import LIFXHTTPKit

class TodayViewController: NSViewController, NCWidgetProviding {
	var client: Client!
	var lights: LightTarget!

	@IBOutlet var lightTargetCollectionView: NSCollectionView?

    override var nibName: String? {
        return "TodayViewController"
    }

	override func viewDidLoad() {
		super.viewDidLoad()

		client = Client(accessToken: "cea46dfc99b012ad8f3373204ac11c80d09ef49d69f1b8f97a64e050e6f75b77")
		lights = client.allLightTarget()
		lightTargetCollectionView?.backgroundColors = [NSColor.clearColor()]
	}

	// MARK: NCWidgetProviding
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)!) {
		client.fetch { (error) in
			if error != nil {
				completionHandler(.Failed)
				return
			}

			self.lightTargetCollectionView?.content = self.lights.toLightTargets()
			completionHandler(.NewData)
		}
    }
}
