import Foundation

class Manager {
    static let shared = Manager()
    private init() {}
    
    let defaults = UserDefaults.standard
    let keyImage = "image"
    let keyUser = "user"
    
    func saveImage(data: Data) {
        defaults.set(data, forKey: keyImage)
        defaults.synchronize()
    }
    
    func loadImage() -> Data? {
        guard let data = defaults.value(forKey: keyImage) as? Data else {
            return nil
        }
        return data
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
}
