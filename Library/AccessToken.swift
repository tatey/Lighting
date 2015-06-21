import SSKeychain

class AccessToken {
	static let AccessTokenDidChangeNotificationName: String = "com.tatey.LIFXWidgetMac.notification.access-token-did-change"

	private static let KeychainService: String = "com.tatey.LIFXWidgetMac"
	private static let KeychainAccount: String = "access-token"

	static func getAccessToken() -> String? {
		return SSKeychain.passwordForService(AccessToken.KeychainService, account: AccessToken.KeychainAccount)
	}

	static func setAccessToken(accessToken: String) -> Bool {
		return SSKeychain.setPassword(accessToken, forService: AccessToken.KeychainService, account: AccessToken.KeychainAccount)
	}
}
