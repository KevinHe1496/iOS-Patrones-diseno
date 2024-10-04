//
//  HeroDetailBuilder.swift
//  SWPatterns
//
//  Created by Kevin Heredia on 4/10/24.
//

import Foundation

import UIKit

final class HeroDetailBuilder {
    
    func build(_ hero: Hero) -> UIViewController{
        
        let useCase = GetHeroDetailUseCase()
        let viewModel = HeroDetailViewModel(useCase: useCase)
        let viewController = HeroDetailViewController(viewModel: viewModel, hero: hero)
        
        viewController.modalPresentationStyle = .fullScreen
        
        return viewController
    }
    
}
