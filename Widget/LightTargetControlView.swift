import Cocoa

protocol LightTargetControlViewDelegate {
	func controlViewDidGetClicked(view: LightTargetControlView)
}

class LightTargetControlView: NSView {
	 var delegate: LightTargetControlViewDelegate?

	required init?(coder: NSCoder) {
		super.init(coder: coder)

		let layer = CALayer()
		layer.backgroundColor = CGColorCreateGenericRGB(0.0, 0.0, 0.0, 0.5)
		self.layer = layer
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
