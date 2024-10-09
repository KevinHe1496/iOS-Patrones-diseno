//
//  HeroDetailBuilder.swift
//  SWPatterns
//
//  Created by Kevin Heredia on 4/10/24.
//

import Foundation

import UIKit

final class HeroDetailBuilder {
    
    private let name: String
    
    init(name: String) {
        self.name = name
    }
    
    func build() -> UIViewController{
        HeroDetailViewController(viewModel: HeroDetailViewModel(heroName: name))
    }
    
}
