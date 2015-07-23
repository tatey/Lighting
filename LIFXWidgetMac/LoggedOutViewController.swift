import Cocoa
import LIFXHTTPKit

protocol LoggedOutViewControllerDelegate: class {
	func loggedOutViewControllerDidLogin(controller: LoggedOutViewController, withToken token: String)
}

class LoggedOutViewController: NSViewController {
	@IBOutlet weak var tokenTextField: NSTextField?
	@IBOutlet weak var loginButton: NSButton?
	@IBOutlet weak var spinner: NSProgressIndicator?
	@IBOutlet weak var errorLabel: NSTextField?

	weak var delegate: LoggedOutViewControllerDelegate?

	@IBAction func loginButtonDidGetTapped(sender: AnyObject?) {
		if let newToken = tokenTextField?.stringValue {
			let client = Client(accessToken: newToken)

			tokenTextField?.enabled = false
			loginButton?.enabled = false
			spinner?.startAnimation(self)
			errorLabel?.hidden = true

			client.fetch { (error) in
				dispatch_async(dispatch_get_main_queue()) {
					if error == nil {
						self.delegate?.loggedOutViewControllerDidLogin(self, withToken: newToken)
					} else {
						self.errorLabel?.hidden = false
					}

					self.spinner?.stopAnimation(self)
					self.tokenTextField?.enabled = true
					self.loginButton?.enabled = true
				}
			}
		}
	}
}
