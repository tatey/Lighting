//
//  Created by Tate Johnson on 21/07/2015.
//  Copyright (c) 2015 Tate Johnson. All rights reserved.
//

import SSKeychain

class AccessToken {
	private static let AccessTokenDidChangeNotificationName: String = "com.tatey.Lighting.notification.access-token-did-change"
	private static let KeychainService: String = "com.tatey.Lighting"
	private static let KeychainAccount: String = "access-token"

	private var observers: [DarwinNotification]

	init() {
		observers = []
	}

	var token: String? {
		get {
			return SSKeychain.passwordForService(AccessToken.KeychainService, account: AccessToken.KeychainAccount)
		}

		set {
			if let newValue = newValue {
				SSKeychain.setPassword(newValue, forService: AccessToken.KeychainService, account: AccessToken.KeychainAccount)
			} else {
				SSKeychain.deletePasswordForService(AccessToken.KeychainService, account: AccessToken.KeychainAccount)
			}
			DarwinNotification.postNotification(AccessToken.AccessTokenDidChangeNotificationName)
		}
	}

	func addObserver(observerHandler: DarwinNotificationObserverHandler) -> DarwinNotification {
		let observer = DarwinNotification(name: AccessToken.AccessTokenDidChangeNotificationName, observerHandler: observerHandler)
		observers.append(observer)
		return observer
	}

	func removeObserver(observer: DarwinNotification) {
		for (index, other) in enumerate(observers) {
			if other === observer {
				observers.removeAtIndex(index)
				break
			}
		}
	}
}
