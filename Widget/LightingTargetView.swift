import Cocoa

class LightingTargetView: NSView {
	required init?(coder: NSCoder) {
		super.init(coder: coder)

		let layer = CALayer()
		layer.backgroundColor = CGColorCreateGenericRGB(0.0, 0.0, 0.0, 0.5)
		self.layer = layer
		self.wantsLayer = true
	}

	override func awakeFromNib() {
		super.awakeFromNib()

		let layer = CALayer()
		layer.backgroundColor = CGColorCreateGenericRGB(0.0, 0.0, 0.0, 0.5)
		self.layer = layer
		self.wantsLayer = true
	}
}
