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
    private let useCase: GetHeroDetailUseCaseContract
    private(set) var hero: Hero?
    private let heroName: String
    
    
    init(heroName: String, useCase: GetHeroDetailUseCaseContract = GetHeroDetailUseCase()) {
        self.heroName = heroName
        self.useCase = useCase
    }
    
    func load() {
        onStateChange.update(newValue: .loading)
        useCase.execute(name: heroName) { [weak self] result in
            do {
                self?.hero = try result.get()
                self?.onStateChange.update(newValue: .success)
            } catch {
                self?.onStateChange.update(newValue: .error(reason: error.localizedDescription))
            }
        }
    }
}
