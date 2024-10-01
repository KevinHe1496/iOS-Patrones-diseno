import UIKit


final class SplashViewController: UIViewController{
    
    @IBOutlet private weak var spinner: UIActivityIndicatorView!
    
    private let viewModel: SplashViewModel
    
    init(viewModel: SplashViewModel){
        self.viewModel = viewModel
        super.init(nibName: "SplashView", bundle: Bundle(for: type(of: self)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Vinculamos los cambios de estado de la lógica (viewModel) con la vista.
        bind()
        // Llamamos a la función que simula la carga (de 3 segundos).
        viewModel.load()
        
    }
    
    // Función que se encarga de enlazar el cambio de estado con la vista.
    private func bind(){
        // Observamos los cambios en el estado usando el 'Binding' del viewModel.
        viewModel.onStateChanged.bind { [weak self] state in
            // Dependiendo del estado, hacemos distintas acciones.
            switch state {
            case .loading:
                // Si estamos en el estado 'loading', activamos la animación del spinner.
                self?.setAnimation(true)
            case .ready:
                // Si estamos en el estado 'ready', desactivamos el spinner y presentamos la pantalla de login.
                self?.setAnimation(false)
                self?.present(LoginBuilder().build(), animated: true)
            case .error:
                // Si ocurre un error, no hacemos nada por ahora.
                break
            }
        }
    }
    
    // Esta función decide si el spinner (indicador de carga) debe empezar o dejar de moverse.
    private func setAnimation(_ animating: Bool){
        
        // Usamos un 'switch' para revisar si el spinner ya está moviéndose o no.
        switch spinner.isAnimating {
            
            // Si el spinner ya se está moviendo (true) y le decimos que deje de moverse (!animating),
            // entonces lo detenemos con stopAnimating().
        case true where !animating:
            spinner.stopAnimating()
            
            // Si el spinner está quieto (false) y le decimos que debe empezar a moverse (animating),
            // entonces lo iniciamos con startAnimating().
        case false where animating:
            spinner.startAnimating()
            
            // Si ya está haciendo lo que queremos (por ejemplo, si ya está quieto y le pedimos que siga quieto),
            // entonces no hacemos nada.
        default:
            break
        }
    }
}
