//
//  HeroesListBuilder.swift
//  SWPatterns
//
//  Created by Kevin Heredia on 2/10/24.
//


import UIKit

final class HeroesListBuilder {
    func build() -> UIViewController {
        let useCase = GetAllHeroesUseCase()
        let viewModel = HeroesListViewModel(useCase: useCase)
        let viewController = HeroesListViewController(viewModel: viewModel)
        
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.modalPresentationStyle = .fullScreen
        return navigationController
    }
}
