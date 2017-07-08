//
//  Created by Tate Johnson on 29/03/2015.
//  Copyright (c) 2015 Tate Johnson. All rights reserved.
//

import Cocoa

protocol LightTargetControlViewDelegate: class {
    func controlViewDidGetClicked(_ view: LightTargetControlView)
    func controlViewDidSetColor(_ view: NSMenuItem)
    func controlViewDidSetBrightness(_ view: NSMenuItem)
}

class LightTargetControlView: NSView {
	static let EnabledBackgroundColor: CGColor = NSColor.white.withAlphaComponent(0.1).cgColor
	static let DisabledBackgroundColor: CGColor = NSColor.black.withAlphaComponent(0.2).cgColor
	static let DefaultDuration: CFTimeInterval = 0.3
	static let DefaultScale: CGFloat = 0.35
	static let ZoomScale: CGFloat = 6.0

	weak var delegate: LightTargetControlViewDelegate?

	var power: Bool = true
	var enabled: Bool = true
	var color: NSColor = NSColor.clear

	fileprivate weak var stateLayer: CAShapeLayer?
	fileprivate var stateTransform: CATransform3D?

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
		let stateFrame = CGRect(x: bounds.midX - stateWidth / 2, y: bounds.midY - stateHeight / 2, width: stateWidth, height: stateHeight)
		let statePath = NSBezierPath(ovalIn: stateFrame).cgPath().takeUnretainedValue() as CGPath
		stateLayer?.frame = stateFrame
		stateLayer?.bounds = stateFrame
		stateLayer?.path = statePath
		stateTransform = stateLayer?.transform
	}

	func setNeedsUpdateAnimated(_ animated: Bool) {
		if let layer = self.layer, let stateLayer = self.stateLayer, let stateTransform = self.stateTransform {
			if enabled {
				let newFillColor = color.cgColor
				let newTransform = power ? CATransform3DScale(stateTransform, LightTargetControlView.ZoomScale, LightTargetControlView.ZoomScale, LightTargetControlView.ZoomScale) : stateTransform

				if animated {
					let colorAnimation = CABasicAnimation(keyPath: "fillColor")
					colorAnimation.duration = LightTargetControlView.DefaultDuration
					colorAnimation.fromValue = stateLayer.fillColor
					colorAnimation.toValue = newFillColor
					stateLayer.add(colorAnimation, forKey: "color")

					let toggleAnimation = CABasicAnimation(keyPath: "transform.scale")
					toggleAnimation.duration = LightTargetControlView.DefaultDuration
					toggleAnimation.fromValue = NSValue(caTransform3D: stateLayer.transform)
					toggleAnimation.toValue = NSValue(caTransform3D: newTransform)
					stateLayer.add(toggleAnimation, forKey: "toggle")
				}

				stateLayer.fillColor = newFillColor
				stateLayer.transform = newTransform
				stateLayer.isHidden = false
				layer.backgroundColor = LightTargetControlView.EnabledBackgroundColor
			} else {
				stateLayer.isHidden = true
				layer.backgroundColor = LightTargetControlView.DisabledBackgroundColor
			}
		}
	}

	override func mouseDown(with theEvent: NSEvent) {
		if !enabled {
			return
		}

		delegate?.controlViewDidGetClicked(self)
	}

    override func rightMouseUp(with theEvent: NSEvent) {
		if !enabled {
			return
		}

		let mainMenu = NSMenu(title: "Context Menu")
		mainMenu.autoenablesItems = false

		let brightnessMenu = addSubmenu("Brightness", mainMenu: mainMenu)
		brightnessMenu.addItem(brightnessItemFor(BrightnessMap.valueForKey(.percent100)))
		brightnessMenu.addItem(brightnessItemFor(BrightnessMap.valueForKey(.percent80)))
		brightnessMenu.addItem(brightnessItemFor(BrightnessMap.valueForKey(.percent60)))
		brightnessMenu.addItem(brightnessItemFor(BrightnessMap.valueForKey(.percent40)))
		brightnessMenu.addItem(brightnessItemFor(BrightnessMap.valueForKey(.percent20)))

		let whitesMenu = addSubmenu("Whites", mainMenu: mainMenu)
		whitesMenu.addItem(colorItemFor(ColorMap.valueForKey(.hotWhite)))
		whitesMenu.addItem(colorItemFor(ColorMap.valueForKey(.warmWhite)))
		whitesMenu.addItem(colorItemFor(ColorMap.valueForKey(.coolWhite)))
		whitesMenu.addItem(colorItemFor(ColorMap.valueForKey(.coldWhite)))
		whitesMenu.addItem(colorItemFor(ColorMap.valueForKey(.blueWhite)))

		let colorsMenu = addSubmenu("Colors", mainMenu: mainMenu)
		colorsMenu.addItem(colorItemFor(ColorMap.valueForKey(.red)))
		colorsMenu.addItem(colorItemFor(ColorMap.valueForKey(.blue)))
		colorsMenu.addItem(colorItemFor(ColorMap.valueForKey(.green)))
		colorsMenu.addItem(colorItemFor(ColorMap.valueForKey(.orange)))
		colorsMenu.addItem(colorItemFor(ColorMap.valueForKey(.yellow)))
		colorsMenu.addItem(colorItemFor(ColorMap.valueForKey(.cyan)))
		colorsMenu.addItem(colorItemFor(ColorMap.valueForKey(.purple)))
		colorsMenu.addItem(colorItemFor(ColorMap.valueForKey(.pink)))

		NSMenu.popUpContextMenu(mainMenu, with: theEvent, for: self)
    }

    fileprivate func addSubmenu(_ title: String, mainMenu: NSMenu) -> NSMenu {
        let submenuItem = NSMenuItem(title: title, action: nil, keyEquivalent: "")
        let submenu = NSMenu()
        mainMenu.setSubmenu(submenu, for: submenuItem)
        mainMenu.addItem(submenuItem)
        return submenu
    }

	fileprivate func brightnessItemFor(_ value: BrightnessMap.Value) -> NSMenuItem{
		let menuItem = NSMenuItem()
		menuItem.title = value.description
		menuItem.action = "controlViewDidSetBrightness:"
		menuItem.target = delegate
		menuItem.keyEquivalent = ""
		menuItem.representedObject = value
		menuItem.isEnabled = true
		return menuItem
	}

    fileprivate func colorItemFor(_ value: ColorMap.Value) -> NSMenuItem{
        let menuItem = NSMenuItem()
        menuItem.title = value.description
        menuItem.action = "controlViewDidSetColor:"
        menuItem.target = delegate
        menuItem.keyEquivalent = ""
        menuItem.representedObject = value
        menuItem.isEnabled = true
        return menuItem
    }
}
