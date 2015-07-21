import Cocoa

protocol LightTargetControlViewDelegate: class {
	func controlViewDidGetClicked(view: LightTargetControlView)
}

class LightTargetControlView: NSView {
	weak var delegate: LightTargetControlViewDelegate?
	var enabled: Bool = true

	required init?(coder: NSCoder) {
		super.init(coder: coder)

		layer = CALayer()
		layer?.cornerRadius = 5.0
		wantsLayer = true
	}

	override func mouseDown(theEvent: NSEvent) {
		
	}

	override func mouseUp(theEvent: NSEvent) {
		if enabled {
			delegate?.controlViewDidGetClicked(self)
		}
	}

	override func mouseDragged(theEvent: NSEvent) {

	}
}
