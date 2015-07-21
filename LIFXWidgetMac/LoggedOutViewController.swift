import Cocoa

protocol LoggedOutViewControllerDelegate: class {
	func loggedOutViewControllerDidFinish(controller: LoggedOutViewController)
}

class LoggedOutViewController: NSViewController {
	weak var delegate: LoggedOutViewControllerDelegate?

	@IBAction func buttonDidGetTapped(sender: AnyObject?) {
		delegate?.loggedOutViewControllerDidFinish(self)
	}
}
