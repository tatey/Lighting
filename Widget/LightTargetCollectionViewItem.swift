//
//  Created by Tate Johnson on 29/03/2015.
//  Copyright (c) 2015 Tate Johnson. All rights reserved.
//

import Cocoa
import LIFXHTTPKit

class LightTargetCollectionViewItem: NSCollectionViewItem, LightTargetControlViewDelegate {
	static let duration: Float = 0.5

	@IBOutlet weak var controlView: LightTargetControlView?
	@IBOutlet weak var labelTextField: NSTextField?

	var lightTarget: LightTarget { return representedObject as! LightTarget }
	var observer: LightTargetObserver?

	override func viewWillAppear() {
		super.viewWillAppear()

		observer = lightTarget.addObserver { [unowned self] in
			DispatchQueue.main.async {
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

	fileprivate func setNeedsUpdateAnimated(_ animated: Bool) {
		let newAlpha: CGFloat = lightTarget.connected ? 1.0 : 0.5
		labelTextField?.alphaValue = newAlpha
		labelTextField?.stringValue = lightTarget.label

		if lightTarget.selector.type == .All {
			controlView?.color = NSColor.white
		} else {
			controlView?.color = lightTarget.color.toNSColor()
		}
		controlView?.enabled = lightTarget.connected
		controlView?.power = lightTarget.power
		controlView?.setNeedsUpdateAnimated(animated)
	}

	// MARK: LightControlViewDelegate

	func controlViewDidGetClicked(_ view: LightTargetControlView) {
		lightTarget.setPower(!lightTarget.power, duration: LightTargetCollectionViewItem.duration)
	}

    func controlViewDidSetColor(_ view: NSMenuItem) {
		if let color = view.representedObject as? ColorMap.Value {
			lightTarget.setColor(color.value, duration: LightTargetCollectionViewItem.duration)
		}
    }

    func controlViewDidSetBrightness(_ view: NSMenuItem) {
		if let brightness = view.representedObject as? BrightnessMap.Value {
			lightTarget.setBrightness(brightness.value, duration: LightTargetCollectionViewItem.duration)
		}
    }
}
