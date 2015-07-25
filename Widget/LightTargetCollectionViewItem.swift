import Cocoa
import LIFXHTTPKit

class LightTargetCollectionViewItem: NSCollectionViewItem, LightTargetControlViewDelegate {
	@IBOutlet weak var controlView: LightTargetControlView?
	@IBOutlet weak var labelTextField: NSTextField?

	var lightTarget: LightTarget { return representedObject as! LightTarget }
	var observer: LightTargetObserver?

	override func viewWillAppear() {
		super.viewWillAppear()

		observer = lightTarget.addObserver { [unowned self] in
			dispatch_async(dispatch_get_main_queue()) {
				self.updateViewsAnimated(true)
			}
		}
		controlView?.delegate = self
	}

	override func viewDidAppear() {
		super.viewDidAppear()

		updateViewsAnimated(false)
	}

	override func viewWillDisappear() {
		super.viewWillDisappear()

		if let observer = self.observer {
			lightTarget.removeObserver(observer)
		}
		controlView?.delegate = nil
	}

	private func updateViewsAnimated(animated: Bool) {
		controlView?.setPower(lightTarget.power, animated: animated)
		labelTextField?.stringValue = lightTarget.label
	}

	// MARK: LightControlViewDelegate

	func controlViewDidGetClicked(view: LightTargetControlView) {
		lightTarget.setPower(!lightTarget.power, duration: 0.5)
	}
}
