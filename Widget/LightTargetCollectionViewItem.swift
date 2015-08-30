//
//  Created by Tate Johnson on 29/03/2015.
//  Copyright (c) 2015 Tate Johnson. All rights reserved.
//

import Cocoa
import LIFXHTTPKit

class LightTargetCollectionViewItem: NSCollectionViewItem, LightTargetControlViewDelegate {
	@IBOutlet weak var controlView: LightTargetControlView?
	@IBOutlet weak var labelTextField: NSTextField?

	var lightTarget: LightTarget { return representedObject as! LightTarget }
	var observer: LightTargetObserver?

	override func viewWillAppear() {
		super.viewWillAppear()

		observer = lightTarget.addObserver { [unowned self] in
			dispatch_async(dispatch_get_main_queue()) {
				self.setNeedsUpdateAnimated(true)
			}
		}
		controlView?.delegate = self
	}

	override func viewDidAppear() {
		super.viewDidAppear()

		setNeedsUpdateAnimated(false)
	}

	override func viewWillDisappear() {
		super.viewWillDisappear()

		if let observer = self.observer {
			lightTarget.removeObserver(observer)
		}
		controlView?.delegate = nil
	}

	private func setNeedsUpdateAnimated(animated: Bool) {
		let newAlpha: CGFloat = lightTarget.connected ? 1.0 : 0.5
		labelTextField?.alphaValue = newAlpha
		labelTextField?.stringValue = lightTarget.label

		if lightTarget.selector.type == .All {
			controlView?.color = NSColor.whiteColor()
		} else {
			controlView?.color = lightTarget.color.toNSColor()
		}
		controlView?.enabled = lightTarget.connected
		controlView?.power = lightTarget.power
		controlView?.setNeedsUpdateAnimated(animated)
	}

	// MARK: LightControlViewDelegate

	func controlViewDidGetClicked(view: LightTargetControlView) {
		lightTarget.setPower(!lightTarget.power, duration: 0.5)
	}

    func controlViewDidSetColor(view: NSMenuItem) {
        let color_string = view.representedObject as? String

        var mapping = [
            "Hot White": Color.white(2500),
            "Warm White": Color.white(3500),
            "Cool White": Color.white(4500),
            "Cold White": Color.white(5500),
            "Blue White": Color.white(9000),
            "Red":        Color.color(0,   saturation: 1),
            "Orange":     Color.color(40,  saturation: 1),
            "Yellow":     Color.color(60,  saturation: 1),
            "Green":      Color.color(120, saturation: 1),
            "Cyan":       Color.color(180, saturation: 1),
            "Blue":       Color.color(240, saturation: 1),
            "Purple":     Color.color(280, saturation: 1),
            "Pink":       Color.color(320, saturation: 1),
        ]

        lightTarget.setColor(mapping[color_string!]!, duration: 0.5)
    }

    func controlViewDidSetBrightness(view: NSMenuItem) {
        let brightness = view.representedObject as? String
        var mapping = [
            "100%": 1.0,
            "80%":  0.8,
            "60%":  0.6,
            "40%":  0.4,
            "20%":  0.2,
        ]

        lightTarget.setBrightness(mapping[brightness!]!, duration: 0.5)
    }

}
