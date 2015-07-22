import Cocoa
import LIFXHTTPKit

protocol LoggedOutViewControllerDelegate: class {
	func loggedOutViewControllerDidLogin(controller: LoggedOutViewController, withToken token: String)
}

class LoggedOutViewController: NSViewController {
	@IBOutlet weak var tokenTextField: NSTextField?
	@IBOutlet weak var loginButton: NSButton?

	weak var delegate: LoggedOutViewControllerDelegate?

	@IBAction func loginButtonDidGetTapped(sender: AnyObject?) {
		if let textField = tokenTextField, button = loginButton {
			let newToken = textField.stringValue
			let client = Client(accessToken: newToken)

			textField.enabled = false
			button.enabled = false

			client.fetch { (error) in
				dispatch_async(dispatch_get_main_queue()) {
					if error == nil {
						self.delegate?.loggedOutViewControllerDidLogin(self, withToken: newToken)
					}

					textField.enabled = true
					button.enabled = true
				}
			}
		}
	}
}
