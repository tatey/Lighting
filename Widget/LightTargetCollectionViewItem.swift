import Cocoa

class LightTargetCollectionViewItem: NSCollectionViewItem, LightTargetControlViewDelegate {
	@IBOutlet var controlView: LightTargetControlView?

	override func viewWillAppear() {
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
