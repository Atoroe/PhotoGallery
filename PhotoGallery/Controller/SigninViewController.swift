import UIKit

class SigninViewController: UIViewController {
    
    @IBOutlet weak var signInView: UIView!
    @IBOutlet weak var signUpBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var blurryVisualEffect: UIVisualEffectView!
    
    let signInXib = SigninView.instanceFromNib()
    let roundCornerSize: CGFloat = 20
    let duration = 0.3
    let blurryAlpha: CGFloat = 0.8
    let buttonTitleColorIfDisable = UIColor.systemGray4
    
    var initialConstraintHeight = CGFloat()
    var userName = String()
    var password = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        overrideUserInterfaceStyle = .light
        self.registerForKeyboardNotifications()
        self.initialConstraintHeight = self.signUpBottomConstraint.constant
        self.signInView.layer.cornerRadius = self.roundCornerSize
        self.addXib()
        
    }
    
    @IBAction func signUpButtonTouch(_ sender: UIButton) {
        guard let controller = self.storyboard?.instantiateViewController(withIdentifier: "SignupViewController") as? SignupViewController else {return}
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    private func addXib() {
        signInXib.delegate = self
        self.signInView.addSubview(signInXib)
        
    }
    
    private func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillChange(_ notification: NSNotification) {
        guard let keyboardFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        
        if notification.name == UIResponder.keyboardWillShowNotification {
            self.signUpBottomConstraint.constant = keyboardFrame.height
            self.view.layoutIfNeeded()
            self.blurryWillChange(statment: true)
        } else {
            self.signUpBottomConstraint.constant = self.initialConstraintHeight
            self.view.layoutIfNeeded()
            self.blurryWillChange(statment: false)
            
        }
    }
    
    private func blurryWillChange(statment: Bool) {
        UIView.animate(withDuration: self.duration,  animations: {
            self.blurryVisualEffect.alpha = statment ? self.blurryAlpha : 0
        })
    }
    
    private func autorisation(name: String, password: String) {
        let autorizationAccess = AutorizationManager.shared.checkingAtorization(name: name, password: password)
        if  autorizationAccess {
            self.signInXib.userNameTextField.text = nil
            self.signInXib.passwordTextField.text = nil
            guard let controller = self.storyboard?.instantiateViewController(withIdentifier: "GalleryViewController") as? GalleryViewController else {return}
            self.navigationController?.pushViewController(controller, animated: true)
        } else {
            self.signInXib.userNameTextField.text = nil
            self.signInXib.passwordTextField.text = nil
            self.signInXib.autorizationButton.isUserInteractionEnabled = false
            self.signInXib.autorizationButton.setTitleColor(self.buttonTitleColorIfDisable, for: .normal)
        }
    }
}

extension SigninViewController: SigninViewDelegat {
    func getData() {
        self.userName = self.signInXib.userName
        self.password = self.signInXib.password
        self.autorisation(name: self.userName, password: self.password)
    }
}

