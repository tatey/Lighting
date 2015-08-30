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

	override func mouseDown(theEvent: NSEvent) {
		
	}

	override func mouseUp(theEvent: NSEvent) {
		if enabled {
			delegate?.controlViewDidGetClicked(self)
		}
	}

    override func rightMouseDown(theEvent: NSEvent) {

    }

    override func rightMouseUp(theEvent: NSEvent) {
        if enabled {
            let mainMenu = NSMenu(title: "Context menu")
            mainMenu.autoenablesItems = false

            var brightnessMenu = addSubmenu("Brightness", mainMenu: mainMenu)
            brightnessMenu.addItem(brightnessItemFor("100%"))
            brightnessMenu.addItem(brightnessItemFor("80%"))
            brightnessMenu.addItem(brightnessItemFor("60%"))
            brightnessMenu.addItem(brightnessItemFor("40%"))
            brightnessMenu.addItem(brightnessItemFor("20%"))

            var whitesMenu = addSubmenu("Whites", mainMenu: mainMenu)
            whitesMenu.addItem(colorItemFor("Hot White"))
            whitesMenu.addItem(colorItemFor("Warm White"))
            whitesMenu.addItem(colorItemFor("Cool White"))
            whitesMenu.addItem(colorItemFor("Cold White"))
            whitesMenu.addItem(colorItemFor("Blue White"))


            var colorsMenu = addSubmenu("Colors", mainMenu: mainMenu)
            colorsMenu.addItem(colorItemFor("Red"))
            colorsMenu.addItem(colorItemFor("Blue"))
            colorsMenu.addItem(colorItemFor("Green"))
            colorsMenu.addItem(colorItemFor("Orange"))
            colorsMenu.addItem(colorItemFor("Yellow"))
            colorsMenu.addItem(colorItemFor("Cyan"))
            colorsMenu.addItem(colorItemFor("Purple"))
            colorsMenu.addItem(colorItemFor("Pink"))

            NSMenu.popUpContextMenu(mainMenu, withEvent: theEvent, forView: self)
        }
    }

	override func mouseDragged(theEvent: NSEvent) {

	}

    // Menu creation helpers

    func addSubmenu(title: String, mainMenu: NSMenu) -> NSMenu {
        var submenuItem = NSMenuItem(title: title, action:nil, keyEquivalent: "")
        var submenu = NSMenu()
        mainMenu.setSubmenu(submenu, forItem: submenuItem)
        mainMenu.addItem(submenuItem)
        return submenu
    }

    func colorItemFor(title: String) -> NSMenuItem{
        var menuItem = NSMenuItem()
        menuItem.title = title
        menuItem.action = "controlViewDidSetColor:"
        menuItem.target = delegate
        menuItem.keyEquivalent = ""
        menuItem.representedObject = title
        menuItem.enabled = true
        return menuItem
    }

    func brightnessItemFor(title: String) -> NSMenuItem{
        var menuItem = NSMenuItem()
        menuItem.title = title
        menuItem.action = "controlViewDidSetBrightness:"
        menuItem.target = delegate
        menuItem.keyEquivalent = ""
        menuItem.representedObject = title
        menuItem.enabled = true
        return menuItem
    }

}
