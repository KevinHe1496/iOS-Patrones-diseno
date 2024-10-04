//
//  HeroDetailViewModel.swift
//  SWPatterns
//
//  Created by Kevin Heredia on 4/10/24.
//

import Foundation


enum HeroDetailState: Equatable{
    case loading
    case error(reason: String)
    case success
}

final class HeroDetailViewModel {
    let onStateChange = Binding<HeroDetailState>()
    private(set) var hero: [Hero] = []
    private let useCase: GetHeroDetailUseCaseContract
    
    
    init(useCase: GetHeroDetailUseCaseContract) {
        self.useCase = useCase
    }
    
    func load() {
        onStateChange.update(newValue: .loading)
        useCase.execute { [weak self] result in
            do {
                self?.hero = try result.get()
                self?.onStateChange.update(newValue: .success)
            } catch {
                self?.onStateChange.update(newValue: .error(reason: error.localizedDescription))
            }
        }
    }
}
