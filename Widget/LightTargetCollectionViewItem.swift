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
				self.setNeedsUpdateAnimated(true)
			}
		}
		controlView?.delegate = self
	}

	override func viewDidAppear() {
		super.viewDidAppear()

		setNeedsUpdateAnimated(false)
	}

	override func viewWillDisappear() {
		super.viewWillDisappear()

		if let observer = self.observer {
			lightTarget.removeObserver(observer)
		}
		controlView?.delegate = nil
	}

	private func setNeedsUpdateAnimated(animated: Bool) {
		let newAlpha: CGFloat = lightTarget.connected ? 1.0 : 0.5
		labelTextField?.alphaValue = newAlpha
		labelTextField?.stringValue = lightTarget.label

		if lightTarget.selector.type == .All {
			controlView?.color = NSColor.whiteColor()
		} else {
			controlView?.color = lightTarget.color.toNSColor()
		}
		controlView?.enabled = lightTarget.connected
		controlView?.power = lightTarget.power
		controlView?.setNeedsUpdateAnimated(animated)
	}

	// MARK: LightControlViewDelegate

	func controlViewDidGetClicked(view: LightTargetControlView) {
		lightTarget.setPower(!lightTarget.power, duration: 0.5)
	}
}
