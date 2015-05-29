import Cocoa

class LightTargetCollectionViewItem: NSCollectionViewItem, LightTargetControlViewDelegate {
	@IBOutlet var controlView: LightTargetControlView?

	override func viewWillAppear() {
		super.viewWillAppear()

		if let lightTarget = self.representedObject as? LightTarget {
			self.controlView?.layer?.backgroundColor = lightTarget.color.CGColor
		}
		self.controlView?.delegate = self
	}

	override func viewWillDisappear() {
		super.viewWillDisappear()

		self.controlView?.delegate = nil
	}

	// MARK: LightControlViewDelegate
	func controlViewDidGetClicked(view: LightTargetControlView) {
		if let lightTarget = self.representedObject as? LightTarget {
			lightTarget.on = !lightTarget.on
		}
	}
}
