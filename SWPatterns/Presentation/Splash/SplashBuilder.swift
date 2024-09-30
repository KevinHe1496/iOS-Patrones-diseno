
import UIKit

// aqui contruimos nuestra pantalla
final class SplashBuilder{
    
    func build() -> UIViewController{
        let viewModel = SplashViewModel()
        return SplashViewController(viewModel: viewModel)
        
    }
}
