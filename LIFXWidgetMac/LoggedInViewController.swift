import Cocoa

protocol LoggedInViewControllerDelegate: class {
	func loggedInViewControllerDidLogout(viewController: LoggedInViewController)
}

class LoggedInViewController: NSViewController {
	weak var delegate: LoggedInViewControllerDelegate?

	override func awakeFromNib() {
		super.awakeFromNib()

		preferredContentSize = view.frame.size
	}

	@IBAction func logoutButtonDidgetTapped(sender: AnyObject?) {
		delegate?.loggedInViewControllerDidLogout(self)
	}
}
