import Foundation

//class ProfileStorage: Codable {
//    var image: Data
//
//    private enum CodingKeys: String, CodingKey {
//        case image
//    }
//
//    init(image: Data) {
//        self.image = image
//    }
//
//    required init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        image = try container.decode(Data.self, forKey: .image)
//    }
//
//    public func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(self.image, forKey: .image)
//    }

struct ProfileStorage: Codable {
    var image: Data
}

