//
//  Created by Tate Johnson on 21/07/2015.
//  Copyright (c) 2015 Tate Johnson. All rights reserved.
//

import Cocoa

class AppWindowController: NSWindowController, LoggedInViewControllerDelegate, LoggedOutViewControllerDelegate {
	var accessToken: AccessToken!

	var loggedInViewController: LoggedInViewController!
	var loggedOutViewController: LoggedOutViewController!

	override func windowDidLoad() {
		super.windowDidLoad()

		let storyboard = NSStoryboard(name: "Main", bundle: nil)
		loggedInViewController = storyboard.instantiateControllerWithIdentifier("LoggedInViewController") as! LoggedInViewController
		loggedInViewController.delegate = self
		loggedOutViewController = storyboard.instantiateControllerWithIdentifier("LoggedOutViewController") as! LoggedOutViewController
		loggedOutViewController.delegate = self

		accessToken = AccessToken()
		if accessToken.token != nil {
			setContentViewController(loggedInViewController)
		} else {
			setContentViewController(loggedOutViewController)
		}
	}

	private func setContentViewController(viewController: NSViewController) {
		if let window = self.window {
			let newSize = viewController.preferredContentSize
			let oldFrame = window.frame
			let newFrame = CGRect(x: oldFrame.origin.x + (oldFrame.width - newSize.width) / 2, y: oldFrame.origin.y + oldFrame.height - newSize.height, width: newSize.width, height: newSize.height)
			window.contentViewController = viewController
			window.setFrame(newFrame, display: true, animate: false)
		}
	}

	// MARK: LoggedInViewControllerDelegate

	func loggedInViewControllerDidLogout(viewController: LoggedInViewController) {
		accessToken.token = nil
		setContentViewController(loggedOutViewController)
	}

	// MARK: LoggedOutViewControllerDelegate

	func loggedOutViewControllerDidLogin(controller: LoggedOutViewController, withToken token: String) {
		accessToken.token = token
		setContentViewController(loggedInViewController)
	}
}
