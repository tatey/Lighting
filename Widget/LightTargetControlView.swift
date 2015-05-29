import Cocoa

protocol LightTargetControlViewDelegate {
	func controlViewDidGetClicked(view: LightTargetControlView)
}

class LightTargetControlView: NSView {
	var delegate: LightTargetControlViewDelegate?

	required init?(coder: NSCoder) {
		super.init(coder: coder)

		self.layer = CALayer()
		self.wantsLayer = true
	}

	override func mouseDown(theEvent: NSEvent) {
		self.delegate?.controlViewDidGetClicked(self)
	}

	override func mouseUp(theEvent: NSEvent) {
	}

	override func mouseDragged(theEvent: NSEvent) {
	}
}
