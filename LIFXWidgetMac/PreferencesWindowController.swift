import Cocoa

class PreferencesWindowController: NSWindowController {
	var test: DarwinNotification?

	override var windowNibName: String? {
		return "PreferencesWindowController"
	}

	override func windowDidLoad() {
		test = DarwinNotification(name: "com.tatey.LIFXWidgetMac.hello") { [unowned self] in
			println("Hello")
		}
	}

	@IBAction func buttonDidGetClicked(sender: AnyObject) {
		DarwinNotification.postNotification("com.tatey.LIFXWidgetMac.hello")
	}
}
