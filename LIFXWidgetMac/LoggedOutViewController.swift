import Cocoa

protocol LoggedOutViewControllerDelegate: class {
	func loggedOutViewControllerDidLogin(controller: LoggedOutViewController)
}

class LoggedOutViewController: NSViewController {
	weak var delegate: LoggedOutViewControllerDelegate?

	@IBAction func loginButtonDidGetTapped(sender: AnyObject?) {
		
	}
}
