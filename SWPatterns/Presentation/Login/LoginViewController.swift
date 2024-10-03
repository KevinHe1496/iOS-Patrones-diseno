
import UIKit

final class LoginViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var userNameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    // MARK: - Inicializadores
    private var viewModel: LoginViewModel  // Instancia del ViewModel que contiene la lógica del login.
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        // Inicializamos la vista con el XIB "LoginView".
        super.init(nibName: "LoginView", bundle: Bundle(for: type(of: self)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Llamamos al método para enlazar la vista con los cambios del estado del ViewModel.
        bind()
    }
    
    @IBAction func onLoginButtonTapped(_ sender: UIButton) {
        // Llamamos al método 'signIn' del ViewModel pasando el nombre de usuario y la contraseña.
        viewModel.signIn(userNameField.text, passwordField.text)
    }
    
    // Método privado para enlazar el estado del ViewModel con las actualizaciones en la vista.
    private func bind(){
        viewModel.onStateChanged.bind { [weak self] state in
            switch state {
            case .success:
                // Si el estado es 'success', mostramos el éxito.
                self?.renderSuccess()
                self?.present(HeroesListBuilder().build(), animated: true)
            case .error(reason: let reason):
                // Si hay un error, mostramos el mensaje de error.
                self?.renderError(reason)
            case .loading:
                // Si está cargando, mostramos el spinner.
                self?.renderLoading()
            }
        }
    }
    
    // MARK: - Métodos para actualizar la interfaz (State rendering functions)
    
    // Actualiza la vista cuando el login es exitoso.
    private func renderSuccess(){
        signInButton.isHidden = false      // Mostramos el botón de login.
        spinner.stopAnimating()            // Detenemos el spinner.
        errorLabel.isHidden = true         // Ocultamos la etiqueta de error.
    }
    
    // Actualiza la vista cuando ocurre un error.
    private func renderError(_ reason: String) {
        signInButton.isHidden = false      // Mostramos el botón de login.
        spinner.stopAnimating()            // Detenemos el spinner.
        errorLabel.isHidden = false        // Mostramos la etiqueta de error.
        errorLabel.text = reason           // Mostramos el mensaje de error.
    }
    
    // Actualiza la vista mientras está cargando (mientras se realiza el login).
    private func renderLoading(){
        signInButton.isHidden = true       // Ocultamos el botón de login.
        spinner.startAnimating()           // Iniciamos el spinner para mostrar que está cargando.
        errorLabel.isHidden = true         // Ocultamos la etiqueta de error.
    }
}

//
//#Preview {
//    LoginBuilder().build()
//}
