import Cocoa
import LIFXHTTPKit

protocol LoggedOutViewControllerDelegate: class {
	func loggedOutViewControllerDidLogin(controller: LoggedOutViewController, withToken token: String)
}

class LoggedOutViewController: NSViewController {
	@IBOutlet weak var tokenTextField: NSTextField?
	@IBOutlet weak var loginButton: NSButton?
	@IBOutlet weak var spinner: NSProgressIndicator?

	weak var delegate: LoggedOutViewControllerDelegate?

	@IBAction func loginButtonDidGetTapped(sender: AnyObject?) {
		if let newToken = tokenTextField?.stringValue {
			let client = Client(accessToken: newToken)

			spinner?.startAnimation(self)
			tokenTextField?.enabled = false
			loginButton?.enabled = false

			client.fetch { (error) in
				dispatch_async(dispatch_get_main_queue()) {
					if error == nil {
						self.delegate?.loggedOutViewControllerDidLogin(self, withToken: newToken)
					}

					self.spinner?.stopAnimation(self)
					self.tokenTextField?.enabled = true
					self.loginButton?.enabled = true
				}
			}
		}
	}
}
