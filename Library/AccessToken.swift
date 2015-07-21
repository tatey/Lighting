import SSKeychain

class AccessToken {
	static let AccessTokenDidChangeNotificationName: String = "com.tatey.LIFXWidgetMac.notification.access-token-did-change"

	private static let KeychainService: String = "com.tatey.LIFXWidgetMac"
	private static let KeychainAccount: String = "access-token"

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
		}
	}
}
