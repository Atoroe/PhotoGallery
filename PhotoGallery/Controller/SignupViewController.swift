import UIKit
import Locksmith

class SignupViewController: UIViewController {
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var returnImageView: UIImageView!
    @IBOutlet weak var doneImageView: UIImageView!
    @IBOutlet weak var addPhotoView: UIView!
    @IBOutlet weak var addPhotoImageView: UIImageView!
    @IBOutlet weak var signUpLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let imagePicker = UIImagePickerController()
    let startColor = UIColor(red: 255/255,
                             green: 224/255,
                             blue: 68/255,
                             alpha: 1)
    let endColor = UIColor(red: 247/255,
                           green: 116/255,
                           blue: 116/255,
                           alpha: 1)
    var userImage = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        hideKeyboardWhenTappedAround()
        self.returnViewTapped()
        self.doneViewTapped()
        self.addPhotoImageViewTapped()
        self.setGradient()
        
        self.chekinNewUser()
        
        self.nameTextField.delegate = self
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
        self.imagePicker.delegate = self
        
        //self.passwordTextField.passwordRules = UITextInputPasswordRules(descriptor: "required: upper; required: lower; required: digit; max-consecutive: 2; minlength: 6;")
    }
    
    @IBAction func signInButtonTouch(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    private func setGradient() {
        self.topView.addGradient(startPointColor: self.startColor, endPointColor: self.endColor)
        let viewArray = [self.returnImageView,
                         self.doneImageView,
                         self.addPhotoView,
                         self.signUpLabel]
        for view in viewArray {
            self.topView.bringSubviewToFront(view!)
        }
    }
    
    private func returnViewTapped() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(returnTap(_:)))
        self.returnImageView.addGestureRecognizer(tap)
        self.returnImageView.isUserInteractionEnabled = true
    }
    
    @objc func returnTap(_ sender: UITapGestureRecognizer) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    private func doneViewTapped() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(doneTap(_:)))
        self.doneImageView.addGestureRecognizer(tap)
        self.doneImageView.isUserInteractionEnabled = true
    }
    
    @objc func doneTap(_ sender: UITapGestureRecognizer) {
        guard let name = self.nameTextField.text, !name.isEmpty,
            let email = self.emailTextField.text, !email.isEmpty,
            let password = self.passwordTextField.text, !password.isEmpty else {
                return
        }
        AutorizationManager.shared.saveRegistrationData(name: name, password: password, email: email)
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    
    private func addPhotoImageViewTapped() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(addPhotoTap(_:)))
        self.addPhotoImageView.addGestureRecognizer(tap)
        self.addPhotoImageView.isUserInteractionEnabled = true
    }
    
    @objc func addPhotoTap(_ sender: UITapGestureRecognizer) {
        self.pick()
    }
    
    private func pick() {
        self.imagePicker.sourceType = .camera
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    private func setUserProfilePhoto(userPhoto: UIImage) {
        let userImageView = UIImageView()
        let sideSize: CGFloat = 150
        let borderWidth: CGFloat = 3
        let borderColor = UIColor.white.cgColor
        userImageView.frame = CGRect(x: self.addPhotoView.center.x - (sideSize / 2),
                                     y: self.addPhotoView.center.y - (sideSize / 2),
                                     width: sideSize,
                                     height: sideSize)
        userImageView.roundCorners(radius: userImageView.frame.size.width / 2)
        userImageView.layer.borderWidth = borderWidth
        userImageView.layer.borderColor = borderColor
        userImageView.clipsToBounds = true
        userImageView.contentMode = .scaleAspectFill
        userImageView.image = userPhoto
        self.addPhotoImageView.removeFromSuperview()
        self.view.addSubview(userImageView)
    }
    
    
    private func chekinNewUser() {
        guard let newUser = ProfileManager.shared.loadUser(), newUser == true else {
            return
        }
        self.nameTextField.isUserInteractionEnabled = false
        self.emailTextField.isUserInteractionEnabled = false
        self.passwordTextField.isUserInteractionEnabled = false
        self.addPhotoImageView.isUserInteractionEnabled = false
    }
    
    
}

extension SignupViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case nameTextField:
            emailTextField.becomeFirstResponder()
        case emailTextField:
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            passwordTextField.resignFirstResponder()
        default:
            break
        }
        return false
    }
}

extension SignupViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            self.userImage = pickedImage
            self.imagePicker.dismiss(animated: true, completion: {() in
                self.setUserProfilePhoto(userPhoto: self.userImage)
                ProfileManager.shared.saveImage(image: pickedImage)
            })
            print(self.userImage)
        }
    }
    
}
