import Cocoa

protocol LightTargetControlViewDelegate: class {
	func controlViewDidGetClicked(view: LightTargetControlView)
}

class LightTargetControlView: NSView {
	weak var delegate: LightTargetControlViewDelegate?

	var power: Bool = true
	var enabled: Bool = true
	var color: NSColor = NSColor.clearColor() {
		didSet {
			stateLayer?.fillColor = color.CGColor
		}
	}

	private weak var stateLayer: CAShapeLayer?
	private var stateTransform: CATransform3D?

	required init?(coder: NSCoder) {
		super.init(coder: coder)

		layer = CALayer()
		layer?.cornerRadius = 5.0
		layer?.masksToBounds = true
		wantsLayer = true

		let stateLayer = CAShapeLayer()
		stateLayer.actions = ["transform": NSNull()]
		layer?.addSublayer(stateLayer)
		self.stateLayer = stateLayer
	}

	override func layout() {
		super.layout()

		let stateFrame = CGRect(x: CGRectGetMidX(bounds) - bounds.width / 4, y: CGRectGetMidY(bounds) - bounds.height / 4, width: bounds.width / 2, height: bounds.height / 2)
		let statePath = NSBezierPath(ovalInRect: stateFrame).CGPath().takeUnretainedValue() as CGPathRef
		stateLayer?.frame = stateFrame
		stateLayer?.bounds = stateFrame
		stateLayer?.path = statePath
		stateTransform = stateLayer?.transform
	}

	func setPower(power: Bool, animated: Bool) {
		if let stateLayer = self.stateLayer, stateTransform = self.stateTransform {
			if power {
				stateLayer.transform = CATransform3DScale(stateTransform, 5.0, 5.0, 5.0)
			} else {
				stateLayer.transform = stateTransform
			}
		}
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
