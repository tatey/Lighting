//
//  Created by Tate Johnson on 21/07/2015.
//  Copyright (c) 2015 Tate Johnson. All rights reserved.
//

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
