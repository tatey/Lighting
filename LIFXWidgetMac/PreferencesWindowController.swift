import Cocoa

class PreferencesWindowController: NSWindowController {
	@IBOutlet weak var accessTokenField: NSSecureTextField?

	override var windowNibName: String? {
		return "PreferencesWindowController"
	}

	override func windowDidLoad() {
		super.windowDidLoad()

		accessTokenField?.stringValue = AccessToken.getAccessToken() ?? ""
	}

	@IBAction func applyButtonDidGetClicked(sender: AnyObject) {
		if let accessTokenField = self.accessTokenField {
			AccessToken.setAccessToken(accessTokenField.stringValue)
			DarwinNotification.postNotification(AccessToken.AccessTokenDidChangeNotificationName)
		}
	}
}
