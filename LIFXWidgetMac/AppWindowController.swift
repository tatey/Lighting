import Cocoa

class AppWindowController: NSWindowController, LoggedInViewControllerDelegate, LoggedOutViewControllerDelegate {
	var accessToken: AccessToken!

	var loggedInViewController: LoggedInViewController!
	var loggedOutViewController: LoggedOutViewController!

	override func windowDidLoad() {
		super.windowDidLoad()

		accessToken = AccessToken()

		let storyboard = NSStoryboard(name: "Main", bundle: nil)
		loggedInViewController = storyboard!.instantiateControllerWithIdentifier("LoggedInViewController") as! LoggedInViewController
		loggedInViewController.delegate = self
		loggedOutViewController = storyboard!.instantiateControllerWithIdentifier("LoggedOutViewController") as! LoggedOutViewController
		loggedOutViewController.delegate = self

		if accessToken.token != nil {
			contentViewController = loggedInViewController
		} else {
			contentViewController = loggedOutViewController
		}
	}

	// MARK: LoggedInViewControllerDelegate

	func loggedInViewControllerDidFinished(viewController: LoggedInViewController) {
		contentViewController = loggedOutViewController
	}

	// MARK: LoggedOutViewControllerDelegate

	func loggedOutViewControllerDidFinish(controller: LoggedOutViewController) {
		contentViewController = loggedInViewController
	}
}
