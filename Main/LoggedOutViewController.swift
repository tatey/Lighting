//
//  Created by Tate Johnson on 21/07/2015.
//  Copyright (c) 2015 Tate Johnson. All rights reserved.
//

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

	override func awakeFromNib() {
		super.awakeFromNib()

		preferredContentSize = view.frame.size
	}

	override func viewDidAppear() {
		super.viewDidAppear()

		tokenTextField?.becomeFirstResponder()
	}

	@IBAction func loginButtonDidGetTapped(sender: AnyObject?) {
		if let newToken = tokenTextField?.stringValue {
			let client = Client(accessToken: newToken)

			tokenTextField?.enabled = false
			loginButton?.enabled = false
			spinner?.startAnimation(self)
			errorLabel?.hidden = true

			client.fetch { (errors) in
				dispatch_async(dispatch_get_main_queue()) {
					if errors.count > 0 {
						self.errorLabel?.hidden = false
					} else {
						self.tokenTextField?.stringValue = ""
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
