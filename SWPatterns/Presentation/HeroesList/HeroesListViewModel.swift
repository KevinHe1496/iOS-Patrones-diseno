//
//  HeroesListViewModel.swift
//  SWPatterns
//
//  Created by Kevin Heredia on 2/10/24.
//

import Foundation

enum HeroesListState: Equatable {
    case loading
    case error(reason: String)
    case success
    
}

final class HeroesListViewModel {
    let onStateChanged = Binding<HeroesListState>()
    private(set) var heroes: [Hero] = []
    private let useCase: GetAllHeroesUseCaseContract
    
    // Añadir un closure para manejar la navegación
    var onHeroSelected: ((Hero) -> Void)?
    
    init(useCase: GetAllHeroesUseCaseContract) {
        self.useCase = useCase
    }
    
    func load() {
        onStateChanged.update(newValue: .loading)
        useCase.execute { [weak self] result in
            do {
                self?.heroes = try result.get()
                self?.onStateChanged.update(newValue: .success)
            }catch{
                self?.onStateChanged.update(newValue: .error(reason: error.localizedDescription))
            }
        }
    }
    
    // Método que se llama cuando un héroe es seleccionado
    func selectHero(at index: Int) {
        let hero = heroes[index]
        onHeroSelected?(hero) // Aquí pasamos el héroe seleccionado a través del closure
    }
    
}
