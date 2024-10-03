//
//  HeroesListViewModel.swift
//  SWPatterns
//
//  Created by Kevin Heredia on 2/10/24.
//

import Foundation

enum HeroesListState {
    case loading
    case error(reason: String)
    case success
    
}

final class HeroesListViewModel {
    let onStateChanged = Binding<HeroesListState>()
    private(set) var heroes: [Hero] = []
    private let useCase: GetAllHeroesUseCaseContract
    
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
}
