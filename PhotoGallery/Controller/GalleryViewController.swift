import UIKit

class GalleryViewController: UIViewController {
    
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var galleryLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userSettingsImageView: UIImageView!
    @IBOutlet weak var appSettingsImageView: UIImageView!
    
    let plusView = UIView()
    let plusImageView = UIImageView()
    let imagePicker = UIImagePickerController()
    let startColor = UIColor(red: 255/255,
                             green: 224/255,
                             blue: 68/255,
                             alpha: 1)
    let endColor = UIColor(red: 247/255,
                           green: 116/255,
                           blue: 116/255,
                           alpha: 1)
    
    var photoCollection = [PhotoCollectionStorage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imagePicker.delegate = self
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        overrideUserInterfaceStyle = .light
        
        self.setGradient()
        self.setPlusView()
        self.setProfilePfoto(profile: self.profileImageView)
        self.plusTapped()
        self.userSettingsTapped()
        self.updatePhotoCollection()
    }
    
    private func updatePhotoCollection() {
        guard let photoCollection = UserDefaults.standard.value([PhotoCollectionStorage].self, forKey: "myCollection") else {return}
        self.photoCollection = photoCollection
        self.collectionView.reloadData()
    }
    
    private func setPlusView() {
        let sideSize: CGFloat = 80
        let image = "plus"
        let borderWidth: CGFloat = 5
        let borderColor = UIColor.white.cgColor
        plusView.frame = CGRect(x: self.view.frame.size.width / 2 - (sideSize / 2),
                                y: self.bottomView.frame.origin.y - (sideSize / 2),
                                width: sideSize,
                                height: sideSize)
        plusView.roundCorners(radius: plusView.frame.size.width / 2)
        plusView.backgroundColor = UIColor.orange
        plusView.layer.borderWidth = borderWidth
        plusView.layer.borderColor = borderColor
        plusImageView.frame = CGRect(x: plusView.center.x - (sideSize / 4),
                                     y: plusView.center.y - (sideSize / 4),
                                     width: sideSize/2,
                                     height: sideSize/2)
        plusImageView.image = UIImage(named: image)
        
        self.view.addSubview(plusView)
        self.view.addSubview(plusImageView)
    }
    
    private func setGradient() {
        self.topView.addGradient(startPointColor: self.startColor, endPointColor: self.endColor)
        self.bottomView.addGradient(startPointColor: self.startColor, endPointColor: self.endColor)
        self.topView.bringSubviewToFront(self.galleryLabel)
        self.bottomView.bringSubviewToFront(self.appSettingsImageView)
        self.bottomView.bringSubviewToFront(self.userSettingsImageView)
    }
    
    private func plusTapped() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(plusTap(_:)))
        self.plusView.addGestureRecognizer(tap)
        self.plusView.isUserInteractionEnabled = true
    }
    
    @objc func plusTap(_ sender: UITapGestureRecognizer) {
        self.pick()
    }
    
    private func pick() {
        self.imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    private func userSettingsTapped() {
           let tap = UITapGestureRecognizer(target: self, action: #selector(userSettingsTap(_:)))
           self.userSettingsImageView.addGestureRecognizer(tap)
           self.userSettingsImageView.isUserInteractionEnabled = true
       }
       
       @objc func userSettingsTap(_ sender: UITapGestureRecognizer) {
        guard let controller = self.storyboard?.instantiateViewController(identifier: "SettingsViewController") as? SettingsViewController else {return}
        self.navigationController?.pushViewController(controller, animated: true)
       }
    
    private func setProfilePfoto(profile: UIImageView) {
        let userImage = ProfileManager.shared.loadImage() ?? UIImage(named: "userProfile")
        self.topView.bringSubviewToFront(profile)
        profile.roundCorners(radius: profile.frame.size.width / 2)
        profile.layer.borderWidth = 2
        profile.layer.borderColor = UIColor.white.cgColor
        profile.clipsToBounds = true
        profile.contentMode = .scaleAspectFill
        profile.image = userImage
    }
    
    private func saveImage(image: UIImage) {
        
        
    }
    
}

extension GalleryViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            let photo = PhotoCollectionStorage(image: pickedImage)
            self.photoCollection.append(photo)
            self.collectionView.reloadData()
            self.imagePicker.dismiss(animated: true, completion: {() in
                UserDefaults.standard.set(encodable: self.photoCollection, forKey: "myCollection")
                print("save true")
            })
        }
    }
}

extension GalleryViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photoCollection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as? PhotoCell else {
            return UICollectionViewCell()
        }
        cell.photoImageView.roundCorners(radius: 20)
        cell.photoImageView.contentMode = .scaleAspectFill
        cell.photoImageView.image = self.photoCollection[indexPath.row].image
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: collectionView.frame.size.width / 2 - 5,
                      height: (collectionView.frame.size.width / 2 - 5) * 4 / 3)
    }
}
