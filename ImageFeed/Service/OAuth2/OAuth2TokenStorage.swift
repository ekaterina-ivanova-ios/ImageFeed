import Foundation
import SwiftKeychainWrapper

final class OAuth2TokenStorage {

    var token: String? {
        get {
            loadFromKeyChain()
        }
        set {
            saveToKeyChain(value: newValue)
        }
    }

    private func loadFromKeyChain() -> String? {
        let token: String? = KeychainWrapper.standard.string(forKey: "bearerToken")
        return token
    }

    private func saveToKeyChain(value: String?) {
        guard let token = value else { return }
        let isSuccess = KeychainWrapper.standard.set(token, forKey: "bearerToken")
        guard isSuccess else {
            print("Can't save data to KeyChain")
            return
        }
    }
}
