//
//  Created by Tate Johnson on 26/03/2015.
//  Copyright (c) 2015 Tate Johnson. All rights reserved.
//

import Cocoa
import NotificationCenter
import LIFXHTTPKit

class TodayViewController: NSViewController, NCWidgetProviding {
	static let DefaultMargin: CGFloat = 5.0 // Derived from margin between collection view and label in TodayViewController.xib
	static let EmptyString: String = ""

	@IBOutlet weak var lightsCollectionView: LightTargetCollectionView?
	@IBOutlet weak var errorLabel: NSTextField?

	var accessToken: AccessToken!
	var accessTokenObserver: DarwinNotification?
	var client: Client!
	var allLightTarget: LightTarget!

    override var nibName: String? {
        return "TodayViewController"
    }

	override func viewDidLoad() {
		super.viewDidLoad()

		accessToken = AccessToken()
		client = Client(accessToken: accessToken.token ?? TodayViewController.EmptyString)
		allLightTarget = client.allLightTarget()

		accessTokenObserver = accessToken.addObserver {
			self.client = Client(accessToken: self.accessToken.token ?? TodayViewController.EmptyString)
			self.lightsCollectionView?.content = self.lightTargetsBySortingAlphabetically(self.allLightTarget)
			self.setNeedsUpdate()
		}

		if #available(OSX 10.11, *) {
			fetch()
		}

		lightsCollectionView?.backgroundColors = [NSColor.clearColor()]
	}

	deinit {
		if let observer = accessTokenObserver {
			accessToken.removeObserver(observer)
		}
	}

	private func lightTargetsBySortingAlphabetically(lightTarget: LightTarget) -> [LightTarget] {
		return [lightTarget] + lightTarget.toLightTargets().sort { (lhs, rhs) in
			return lhs.label < rhs.label
		}
	}

	private func setNeedsUpdate() {
		if let lightsCollectionView = self.lightsCollectionView, errorLabel = self.errorLabel {
			var newSize = lightsCollectionView.sizeThatFits(NSSize(width: view.frame.width, height: CGFloat.max))

			if errorLabel.stringValue == TodayViewController.EmptyString {
				errorLabel.frame = CGRectZero
			} else {
				errorLabel.sizeToFit()
			}
			newSize.height += errorLabel.frame.height

			preferredContentSize = NSSize(width: view.frame.width, height: newSize.height + TodayViewController.DefaultMargin)
		}
	}

	private func fetch(completionHandler: (([NSError]) -> Void)? = nil) {
		client.fetch { (errors) in
			dispatch_async(dispatch_get_main_queue()) {
				if errors.count > 0 {
					self.errorLabel?.stringValue = "An error occured fetching lights."
					completionHandler?(errors)
				} else {
					self.errorLabel?.stringValue = TodayViewController.EmptyString
					self.lightsCollectionView?.content = self.lightTargetsBySortingAlphabetically(self.allLightTarget)
					completionHandler?([])
				}

				self.setNeedsUpdate()
			}
		}
	}

	// MARK: NCWidgetProviding

	func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)) {
		fetch { (errors) in
			if errors.count > 0 {
				completionHandler(.Failed)
			} else {
				completionHandler(.NewData)
			}
		}
    }

	func widgetMarginInsetsForProposedMarginInsets(defaultMarginInset: NSEdgeInsets) -> NSEdgeInsets {
		return NSEdgeInsets(top: defaultMarginInset.top + TodayViewController.DefaultMargin, left: defaultMarginInset.left - 20.0, bottom: defaultMarginInset.bottom, right: 0.0)
	}
}
