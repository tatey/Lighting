import Cocoa

protocol LoggedInViewControllerDelegate: class {
	func loggedInViewControllerDidFinished(viewController: LoggedInViewController)
}

class LoggedInViewController: NSViewController {
	weak var delegate: LoggedInViewControllerDelegate?

	@IBAction func buttonDidGetTapped(sender: AnyObject?) {
		delegate?.loggedInViewControllerDidFinished(self)
	}
}
