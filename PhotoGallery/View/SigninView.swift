import UIKit

class SigninView: UIView, UITextFieldDelegate {
    
    class func instanceFromNib() -> SigninView {
        return UINib(nibName: "SigninView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! SigninView
    }
    
    @IBOutlet weak var signInView: UIView!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var autorizationButton: UIButton!
    
    let roundCornerSize: CGFloat = 20
    let startColor = UIColor(red: 255/255, green: 224/255, blue: 68/255, alpha: 1)
    let endColor = UIColor(red: 247/255, green: 116/255, blue: 116/255, alpha: 1)
    let buttonTitleColorIfEnable = UIColor.white
    let buttonTitleColorIfDisable = UIColor.systemGray4
    
    var userName = String()
    var password = String()
    
    weak var delegate: SigninViewDelegat?
    
    @IBAction func usernameTextFieldEditing(_ sender: UITextField) {
        self.setButtonIteractionStatus(status: self.textFieldDidChange())
    }
    
    @IBAction func passwordTextFielEditing(_ sender: UITextField) {
        self.setButtonIteractionStatus(status: self.textFieldDidChange())
    }
    
    
    @IBAction func autorizationButtonTouched(_ sender: Any) {
        guard let userName = self.userNameTextField.text,
            let password = self.passwordTextField.text else {
                return
        }
        self.userName = userName
        self.password = password
        delegate?.getData()
    }
    
    func textFieldDidChange() -> Bool {
        guard let usernameText = userNameTextField.text,
            let passwordText = passwordTextField.text else {
                return false
        }
        if !usernameText.isEmpty && !passwordText.isEmpty {
            return true
        } else {
            return false
        }
    }
    
    override func awakeFromNib() {
        self.layer.cornerRadius = self.roundCornerSize
        self.clipsToBounds = true
        self.signInView.addGradient(startPointColor: self.startColor, endPointColor: self.endColor)
        self.userNameTextField.delegate = self
        self.passwordTextField.delegate = self
        
        self.setButtonIteractionStatus(status: false)
    }
    
    func setButtonIteractionStatus(status: Bool) {
        if status {
            self.autorizationButton.isUserInteractionEnabled = true
            autorizationButton.setTitleColor(self.buttonTitleColorIfEnable, for: .normal)
        } else {
            autorizationButton.isUserInteractionEnabled = false
            autorizationButton.setTitleColor(self.buttonTitleColorIfDisable, for: .normal)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case userNameTextField:
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            passwordTextField.resignFirstResponder()
        default:
            break
        }
        return false
    }
    
}

protocol SigninViewDelegat: NSObject {
    func getData()
}

