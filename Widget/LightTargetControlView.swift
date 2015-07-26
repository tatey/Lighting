import Cocoa

protocol LightTargetControlViewDelegate: class {
	func controlViewDidGetClicked(view: LightTargetControlView)
}

class LightTargetControlView: NSView {
	static let enabledBackgroundColor: CGColorRef = NSColor.whiteColor().colorWithAlphaComponent(0.1).CGColor
	static let disabledBackgroundColor: CGColorRef = NSColor.blackColor().colorWithAlphaComponent(0.2).CGColor
	static let defaultScale: CGFloat = 0.35
	static let zoomScale: CGFloat = 6.0

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
		newLayer.backgroundColor = LightTargetControlView.enabledBackgroundColor
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

		let stateWidth = bounds.width * LightTargetControlView.defaultScale
		let stateHeight = bounds.height * LightTargetControlView.defaultScale
		let stateFrame = CGRect(x: CGRectGetMidX(bounds) - stateWidth / 2, y: CGRectGetMidY(bounds) - stateHeight / 2, width: stateWidth, height: stateHeight)
		let statePath = NSBezierPath(ovalInRect: stateFrame).CGPath().takeUnretainedValue() as CGPathRef
		stateLayer?.frame = stateFrame
		stateLayer?.bounds = stateFrame
		stateLayer?.path = statePath
		stateTransform = stateLayer?.transform
	}

	func setNeedsUpdateAnimated(animated: Bool) {
		if let layer = self.layer, stateLayer = self.stateLayer, stateTransform = self.stateTransform {
			if enabled {
				let toValue = power ? CATransform3DScale(stateTransform, LightTargetControlView.zoomScale, LightTargetControlView.zoomScale, LightTargetControlView.zoomScale) : stateTransform
				if animated {
					let animation = CABasicAnimation(keyPath: "transform.scale")
					animation.duration = 0.3
					animation.fromValue = NSValue(CATransform3D: stateLayer.transform)
					animation.toValue = NSValue(CATransform3D: toValue)
					stateLayer.addAnimation(animation, forKey: "toggle")
				}

				stateLayer.transform = toValue
				stateLayer.hidden = false
				layer.backgroundColor = LightTargetControlView.enabledBackgroundColor
			} else {
				stateLayer.hidden = true
				layer.backgroundColor = LightTargetControlView.disabledBackgroundColor
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
