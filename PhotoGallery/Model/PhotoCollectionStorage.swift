import Foundation
import UIKit

class PhotoCollectionStorage: Codable {
    var image: UIImage?
    
    private enum CodingKeys: String, CodingKey {
        case image
    }
    
    init(image: UIImage) {
        self.image = image
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let data = try container.decodeIfPresent(Data.self, forKey: .image) {
            image = UIImage(data: data, scale: 1.0)
        } else {
            return
        }
        
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        if let image = image {
            if let data = image.jpegData(compressionQuality: 0.8) {
                try container.encode(data, forKey: .image)
            }
        }
    }
}

extension UserDefaults {
    
    func set<T: Encodable>(encodable: T, forKey key: String) {
        if let data = try? JSONEncoder().encode(encodable) {
            set(data, forKey: key)
        }
    }
    
    func value<T: Decodable>(_ type: T.Type, forKey key: String) -> T? {
        if let data = object(forKey: key) as? Data,
            let value = try? JSONDecoder().decode(type, from: data) {
            return value
        }
        return nil
    }
}

