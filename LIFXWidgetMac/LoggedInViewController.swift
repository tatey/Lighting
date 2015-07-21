import Cocoa

protocol LoggedInViewControllerDelegate: class {
	func loggedInViewControllerDidLogout(viewController: LoggedInViewController)
}

class LoggedInViewController: NSViewController {
	weak var delegate: LoggedInViewControllerDelegate?

	@IBAction func logoutButtonDidgetTapped(sender: AnyObject?) {
		delegate?.loggedInViewControllerDidLogout(self)
	}
}
