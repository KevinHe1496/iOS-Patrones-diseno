
import UIKit

final class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var userNameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    private var viewModel: LoginViewModel
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "LoginView", bundle: Bundle(for: type(of: self)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    @IBAction func onLoginButtonTapped(_ sender: UIButton) {
        viewModel.signIn(userNameField.text, passwordField.text)
    }
    
    private func bind(){
        viewModel.onStateChanged.bind { [weak self] state in
            switch state{
            
            case .success:
                self?.renderSuccess()
            case .error(reason: let reason):
                self?.renderError(reason)
            case .loading:
                self?.renderLoading()
            }
        }
    }
    
    // MARK: - State rendering functions
    private func renderSuccess(){
        signInButton.isHidden = false
        spinner.stopAnimating()
        errorLabel.isHidden = true
        
    }
    
    private func renderError(_ reason: String) {
        signInButton.isHidden = false
        spinner.stopAnimating()
        errorLabel.isHidden = false
        errorLabel.text = reason
        
    }
    
    private func renderLoading(){
        signInButton.isHidden = true
        spinner.startAnimating()
        errorLabel.isHidden = true
        
    }
}
