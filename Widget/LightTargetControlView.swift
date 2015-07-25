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

		let newLayer = CALayer()
		newLayer.backgroundColor = NSColor(red:0.349, green:0.362, blue:0.374, alpha:1).CGColor
		newLayer.cornerRadius = 5.0
		newLayer.masksToBounds = true
		self.layer = newLayer
		wantsLayer = true

		let newStateLayer = CAShapeLayer()
		newStateLayer.actions = ["transform": NSNull()]
		layer?.addSublayer(newStateLayer)
		self.stateLayer = newStateLayer
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

	func setNeedsUpdateAnimated(animated: Bool) {
		if let layer = self.layer, stateLayer = self.stateLayer, stateTransform = self.stateTransform {
			if enabled {
				stateLayer.hidden = false
				layer.opacity = 1.0

				let toValue = power ? CATransform3DScale(stateTransform, 5.0, 5.0, 5.0) : stateTransform
				if animated {
					let animation = CABasicAnimation(keyPath: "transform.scale")
					animation.duration = 0.3
					animation.fromValue = NSValue(CATransform3D: stateLayer.transform)
					animation.toValue = NSValue(CATransform3D: toValue)
					stateLayer.addAnimation(animation, forKey: "toggle")
				}
				stateLayer.transform = toValue
			} else {
				stateLayer.hidden = true
				layer.opacity = 0.3
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
