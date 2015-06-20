import Cocoa
import NotificationCenter
import LIFXHTTPKit
import SSKeychain

class TodayViewController: NSViewController, NCWidgetProviding {
	@IBOutlet weak var lightTargetCollectionView: LightTargetCollectionView?

	@IBOutlet weak var settingsView: NSView?
	@IBOutlet weak var accessTokenTextField: NSTextField?

	var client: Client!
	var lights: LightTarget!
	private var editing: Bool = false

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

		settingsView?.hidden = !editing
		lightTargetCollectionView?.hidden = editing

		if editing {
			if let settingsView = self.settingsView {
				preferredContentSize = NSSize(width: view.frame.width, height: settingsView.frame.height)
			}
		} else {
			if let lightTargetCollectionView = self.lightTargetCollectionView {
				let sizeThatFits = lightTargetCollectionView.sizeThatFits(NSSize(width: view.frame.width, height: CGFloat.max))
				preferredContentSize = NSSize(width: view.frame.width, height: sizeThatFits.height)
			}
		}
	}

	private func getLightTargetsSortedByLabel() -> [LightTarget] {
		return lights.toLightTargets().sorted { (lhs, rhs) in
			return lhs.label < rhs.label
		}
	}

	override func controlTextDidEndEditing(notification: NSNotification) {
		if let accessTokenTextField = self.accessTokenTextField where notification.object === accessTokenTextField {

		}
	}

	// MARK: NCWidgetProviding

    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)!) {
		client.fetch { [unowned self] (error) in
			if error != nil {
				completionHandler(.Failed)
				return
			}

			self.lightTargetCollectionView?.content = [self.lights] + self.getLightTargetsSortedByLabel()
			self.view.needsLayout = true
			completionHandler(.NewData)
		}
    }

	func widgetMarginInsetsForProposedMarginInsets(defaultMarginInset: NSEdgeInsets) -> NSEdgeInsets {
		return NSEdgeInsets(top: defaultMarginInset.top + 3.0, left: defaultMarginInset.left - 20.0, bottom: 0.0, right: 0.0)
	}

	var widgetAllowsEditing: Bool {
		return true
	}

	func widgetDidBeginEditing() {
		editing = true
		view.needsLayout = true
	}

	func widgetDidEndEditing() {
		editing = false
		view.needsLayout = true
	}
}
