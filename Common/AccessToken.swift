//
//  Created by Tate Johnson on 21/07/2015.
//  Copyright (c) 2015 Tate Johnson. All rights reserved.
//

import SAMKeychain

class AccessToken {
	fileprivate static let AccessTokenDidChangeNotificationName: String = "com.tatey.Lighting.notification.access-token-did-change"
	fileprivate static let KeychainService: String = "com.tatey.Lighting"
	fileprivate static let KeychainAccount: String = "access-token"

	fileprivate var observers: [DarwinNotification]

	init() {
		observers = []
	}

	var token: String? {
		get {
			return SAMKeychain.password(forService: AccessToken.KeychainService, account: AccessToken.KeychainAccount)
		}

		set {
			if let newValue = newValue {
				SAMKeychain.setPassword(newValue, forService: AccessToken.KeychainService, account: AccessToken.KeychainAccount)
			} else {
				SAMKeychain.deletePassword(forService: AccessToken.KeychainService, account: AccessToken.KeychainAccount)
			}
			DarwinNotification.post(AccessToken.AccessTokenDidChangeNotificationName)
		}
	}

	func addObserver(_ observerHandler: @escaping DarwinNotificationObserverHandler) -> DarwinNotification {
		let observer = DarwinNotification(name: AccessToken.AccessTokenDidChangeNotificationName, observerHandler: observerHandler)
		observers.append(observer!)
		return observer!
	}

	func removeObserver(_ observer: DarwinNotification) {
		for (index, other) in observers.enumerated() {
			if other === observer {
				observers.remove(at: index)
				break
			}
		}
	}
}
