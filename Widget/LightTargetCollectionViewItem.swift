import Cocoa
import LIFXHTTPKit

class LightTargetCollectionViewItem: NSCollectionViewItem, LightTargetControlViewDelegate {
	@IBOutlet weak var controlView: LightTargetControlView?
	@IBOutlet weak var labelTextField: NSTextField?

	var lightTarget: LightTarget { return representedObject as! LightTarget }
	var observer: LightTargetObserver!

	override func viewWillAppear() {
		super.viewWillAppear()

		updateUI()
		observer = lightTarget.addObserver { [unowned self] in self.updateUI() }
		controlView?.delegate = self
	}

	override func viewWillDisappear() {
		super.viewWillDisappear()

		lightTarget.removeObserver(observer)
		controlView?.delegate = nil
	}

	private func updateUI() {
		if lightTarget.power {
			controlView?.layer?.backgroundColor = NSColor.whiteColor().CGColor
		} else {
			controlView?.layer?.backgroundColor = NSColor.blackColor().CGColor
		}

		labelTextField?.stringValue = lightTarget.label
	}

	// MARK: LightControlViewDelegate
	func controlViewDidGetClicked(view: LightTargetControlView) {
		lightTarget.setPower(!lightTarget.power, duration: 0.5)
	}
}
