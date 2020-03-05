import Foundation
import UIKit

class PhotoCollectionManager {
//    static let shared = PhotoCollectionManager()
//    private init() {}
//
//    var photoCollection = [PhotoCollectionStorage]()
//    var encodedCollection : Data?
//    //var decodedCollection = [PhotoCollectionStorage]()
//
//    func saveData(image: UIImage) {
//        guard let image = image.jpegData(compressionQuality: 1.0) else {return}
//        let data = PhotoCollectionStorage(image: image)
//        self.photoCollection.append(data)
//        let encoder = JSONEncoder()
//        guard let encoded = try? encoder.encode(self.photoCollection) else {
//            // save `encoded` somewhere
//            return
//        }
//        self.encodedCollection = encoded
//    }
//
//    func loadData() -> [UIImage]? {
//        var jpegCollection = [UIImage]()
//        let decoder = JSONDecoder()
//        guard let encodedCollection = encodedCollection else {return nil}
//        guard let decoded = try? decoder.decode([PhotoCollectionStorage].self, from: encodedCollection) else { return nil}
//        for image in decoded {
//            guard let image = UIImage(data: image.image, scale: 1.0) else {return nil}
//            jpegCollection.append(image)
//        }
//        return jpegCollection
//    }
}
