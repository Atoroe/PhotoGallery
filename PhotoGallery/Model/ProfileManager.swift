import Foundation
import UIKit

class ProfileManager {
    static let shared = ProfileManager()
    private init() {}
    
    let defaults = UserDefaults.standard
    let keyImage = "image"
    let keyUser = "user"
    let keyEmail = "email"
    
    func saveImage(image: UIImage) {
        let data = image.jpegData(compressionQuality: 1.0)
        defaults.set(data, forKey: keyImage)
        defaults.synchronize()
    }
    
    func loadImage() -> UIImage? {
        guard let data = defaults.value(forKey: keyImage) as? Data else { return nil }
        guard let image = UIImage(data: data, scale: 1.0) else {return nil}
        return image
    }
    
    func saveUser(user: Bool) {
        defaults.set(user, forKey: keyUser)
        defaults.synchronize()
    }
    
    func loadUser() -> Bool? {
        guard let user = defaults.value(forKey: keyUser) as? Bool else {
            return nil
        }
        return user
    }
    
    func saveEmail(email: String) {
        defaults.set(email, forKey: keyEmail)
        defaults.synchronize()
    }
    
    func loadEmail() -> String? {
        guard let email = defaults.value(forKey: keyEmail) as? String else {
            return nil
        }
        return email
    }
}






