import Foundation
import Locksmith

class AutorizationManager  {
    private init() {}
    static let shared = AutorizationManager()
    
    let keyUserName = "userName"
    let keyUserPassword = "userPassword"
    
    func saveRegistrationData(name: String, password: String, email: String) {
        do {
            try Locksmith.saveData(data: ["name" : name], forUserAccount: keyUserName)
            try Locksmith.saveData(data: ["password" : password], forUserAccount: keyUserPassword)
            ProfileManager.shared.saveEmail(email: email)
            ProfileManager.shared.saveUser(user: true)
        } catch {
            print("Unable to save data")
        }
    }
    
    func checkingAtorization(name: String, password: String) -> Bool {
        guard let nameDict = Locksmith.loadDataForUserAccount(userAccount: keyUserName) as? [String : String],
            let passwordDict = Locksmith.loadDataForUserAccount(userAccount: keyUserPassword) as? [String : String] else {
                return false
        }
        if  nameDict["name"] == name &&
            passwordDict["password"] == password {
            return true
        } else {
            return false
        }
    }
    
    func updatePassword(newPassword: String) {
        do {
            try Locksmith.updateData(data: ["password" : newPassword], forUserAccount: keyUserPassword)
        } catch {
            print("Unable to update data")
        }
    }
}
