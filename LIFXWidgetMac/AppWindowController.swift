import Cocoa

class AppWindowController: NSWindowController, LoggedInViewControllerDelegate, LoggedOutViewControllerDelegate {
	var accessToken: AccessToken!

	var loggedInViewController: LoggedInViewController!
	var loggedOutViewController: LoggedOutViewController!

	override func windowDidLoad() {
		super.windowDidLoad()

		let storyboard = NSStoryboard(name: "Main", bundle: nil)
		loggedInViewController = storyboard!.instantiateControllerWithIdentifier("LoggedInViewController") as! LoggedInViewController
		loggedInViewController.delegate = self
		loggedOutViewController = storyboard!.instantiateControllerWithIdentifier("LoggedOutViewController") as! LoggedOutViewController
		loggedOutViewController.delegate = self

		accessToken = AccessToken()
		if accessToken.token != nil {
			contentViewController = loggedInViewController
		} else {
			contentViewController = loggedOutViewController
		}
	}

	// MARK: LoggedInViewControllerDelegate

	func loggedInViewControllerDidLogout(viewController: LoggedInViewController) {
		contentViewController = loggedOutViewController
	}

	// MARK: LoggedOutViewControllerDelegate

	func loggedOutViewControllerDidLogin(controller: LoggedOutViewController) {
		contentViewController = loggedInViewController
	}
}
