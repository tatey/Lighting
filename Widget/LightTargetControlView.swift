//
//  Created by Tate Johnson on 29/03/2015.
//  Copyright (c) 2015 Tate Johnson. All rights reserved.
//

import Cocoa

protocol LightTargetControlViewDelegate: class {
    func controlViewDidGetClicked(view: LightTargetControlView)
    func controlViewDidSetColor(view: NSMenuItem)
    func controlViewDidSetBrightness(view: NSMenuItem)
}

class LightTargetControlView: NSView {
	static let EnabledBackgroundColor: CGColorRef = NSColor.whiteColor().colorWithAlphaComponent(0.1).CGColor
	static let DisabledBackgroundColor: CGColorRef = NSColor.blackColor().colorWithAlphaComponent(0.2).CGColor
	static let DefaultScale: CGFloat = 0.35
	static let ZoomScale: CGFloat = 6.0

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
		newLayer.backgroundColor = LightTargetControlView.EnabledBackgroundColor
		newLayer.cornerRadius = 5.0
		newLayer.masksToBounds = true
		self.layer = newLayer
		wantsLayer = true

		let newStateLayer = CAShapeLayer()
		newStateLayer.actions = ["transform": NSNull()] // Disable implicit animations
		layer?.addSublayer(newStateLayer)
		self.stateLayer = newStateLayer
	}

	override func layout() {
		super.layout()

		let stateWidth = bounds.width * LightTargetControlView.DefaultScale
		let stateHeight = bounds.height * LightTargetControlView.DefaultScale
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
				let toValue = power ? CATransform3DScale(stateTransform, LightTargetControlView.ZoomScale, LightTargetControlView.ZoomScale, LightTargetControlView.ZoomScale) : stateTransform
				if animated {
					let animation = CABasicAnimation(keyPath: "transform.scale")
					animation.duration = 0.3
					animation.fromValue = NSValue(CATransform3D: stateLayer.transform)
					animation.toValue = NSValue(CATransform3D: toValue)
					stateLayer.addAnimation(animation, forKey: "toggle")
				}

				stateLayer.transform = toValue
				stateLayer.hidden = false
				layer.backgroundColor = LightTargetControlView.EnabledBackgroundColor
			} else {
				stateLayer.hidden = true
				layer.backgroundColor = LightTargetControlView.DisabledBackgroundColor
			}
		}
	}

	override func mouseUp(theEvent: NSEvent) {
		if !enabled {
			return
		}

		delegate?.controlViewDidGetClicked(self)
	}

    override func rightMouseUp(theEvent: NSEvent) {
		if !enabled {
			return
		}

		let mainMenu = NSMenu(title: "Context Menu")
		mainMenu.autoenablesItems = false

		let brightnessMenu = addSubmenu("Brightness", mainMenu: mainMenu)
		brightnessMenu.addItem(brightnessItemFor(BrightnessMap.valueForKey(.Percent100)))
		brightnessMenu.addItem(brightnessItemFor(BrightnessMap.valueForKey(.Percent80)))
		brightnessMenu.addItem(brightnessItemFor(BrightnessMap.valueForKey(.Percent60)))
		brightnessMenu.addItem(brightnessItemFor(BrightnessMap.valueForKey(.Percent40)))
		brightnessMenu.addItem(brightnessItemFor(BrightnessMap.valueForKey(.Percent20)))

		let whitesMenu = addSubmenu("Whites", mainMenu: mainMenu)
		whitesMenu.addItem(colorItemFor(ColorMap.valueForKey(.HotWhite)))
		whitesMenu.addItem(colorItemFor(ColorMap.valueForKey(.WarmWhite)))
		whitesMenu.addItem(colorItemFor(ColorMap.valueForKey(.CoolWhite)))
		whitesMenu.addItem(colorItemFor(ColorMap.valueForKey(.ColdWhite)))
		whitesMenu.addItem(colorItemFor(ColorMap.valueForKey(.BlueWhite)))

		let colorsMenu = addSubmenu("Colors", mainMenu: mainMenu)
		colorsMenu.addItem(colorItemFor(ColorMap.valueForKey(.Red)))
		colorsMenu.addItem(colorItemFor(ColorMap.valueForKey(.Blue)))
		colorsMenu.addItem(colorItemFor(ColorMap.valueForKey(.Green)))
		colorsMenu.addItem(colorItemFor(ColorMap.valueForKey(.Orange)))
		colorsMenu.addItem(colorItemFor(ColorMap.valueForKey(.Yellow)))
		colorsMenu.addItem(colorItemFor(ColorMap.valueForKey(.Cyan)))
		colorsMenu.addItem(colorItemFor(ColorMap.valueForKey(.Purple)))
		colorsMenu.addItem(colorItemFor(ColorMap.valueForKey(.Pink)))

		NSMenu.popUpContextMenu(mainMenu, withEvent: theEvent, forView: self)
    }

    private func addSubmenu(title: String, mainMenu: NSMenu) -> NSMenu {
        let submenuItem = NSMenuItem(title: title, action: nil, keyEquivalent: "")
        let submenu = NSMenu()
        mainMenu.setSubmenu(submenu, forItem: submenuItem)
        mainMenu.addItem(submenuItem)
        return submenu
    }

	private func brightnessItemFor(value: BrightnessMap.Value) -> NSMenuItem{
		let menuItem = NSMenuItem()
		menuItem.title = value.description
		menuItem.action = "controlViewDidSetBrightness:"
		menuItem.target = delegate
		menuItem.keyEquivalent = ""
		menuItem.representedObject = value
		menuItem.enabled = true
		return menuItem
	}

    private func colorItemFor(value: ColorMap.Value) -> NSMenuItem{
        let menuItem = NSMenuItem()
        menuItem.title = value.description
        menuItem.action = "controlViewDidSetColor:"
        menuItem.target = delegate
        menuItem.keyEquivalent = ""
        menuItem.representedObject = value
        menuItem.enabled = true
        return menuItem
    }
}
