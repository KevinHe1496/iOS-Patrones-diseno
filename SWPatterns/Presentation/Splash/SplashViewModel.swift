import Foundation

enum SplashState {
    case loading
    case error
    case ready
}


final class SplashViewModel{
    var onStateChanged = Binding<SplashState>()
    
    func load() {
        onStateChanged.update(newValue: .loading)
        DispatchQueue.global().asyncAfter(deadline: .now() + 3) { [weak self] in
            DispatchQueue.main.async {
                self?.onStateChanged.update(newValue: .ready)
            }
            
            
        }
    }
}
