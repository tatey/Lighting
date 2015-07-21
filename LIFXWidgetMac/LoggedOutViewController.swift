import Cocoa
import LIFXHTTPKit

protocol LoggedOutViewControllerDelegate: class {
	func loggedOutViewControllerDidLogin(controller: LoggedOutViewController)
}

class LoggedOutViewController: NSViewController {
	@IBOutlet weak var accessTokenSecureTextField: NSSecureTextField?
	@IBOutlet weak var loginButton: NSButton?

	weak var delegate: LoggedOutViewControllerDelegate?

	@IBAction func loginButtonDidGetTapped(sender: AnyObject?) {
		if let textField = accessTokenSecureTextField, button = loginButton {
			textField.enabled = false
			button.enabled = false

			let accessToken = textField.stringValue
			let client = Client(accessToken: accessToken)
			client.fetch { (error) in
				if error == nil {
					self.delegate?.loggedOutViewControllerDidLogin(self)
				}

				textField.enabled = true
				button.enabled = true
			}
		}
	}
}
