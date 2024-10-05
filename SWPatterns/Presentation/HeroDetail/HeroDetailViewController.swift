//
//  HeroDetailViewController.swift
//  SWPatterns
//
//  Created by Kevin Heredia on 4/10/24.
//

import UIKit

class HeroDetailViewController: UIViewController {

    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    @IBOutlet weak var heroImageView: AsyncImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    private let viewModel: HeroDetailViewModel
    private var hero: Hero
 
 
    
    init(viewModel: HeroDetailViewModel, hero: Hero) {
        self.viewModel = viewModel
        self.hero = hero
        super.init(nibName: "HeroDetailViewController", bundle: Bundle(for: type(of: self)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = hero.name
        bind()
        viewModel.load()
        
        
        
       
        
    }
    
    // MARK: - States
    private func bind() {
        viewModel.onStateChange.bind { [weak self] state in
            switch state{
                
            case .loading:
                self?.renderLoading()
            case .error(let error):
                self?.renderError(error)
            case .success:
                self?.renderSuccess()
            }
        }
        
    }
    
    private func renderLoading() {
        titleLabel.text = ""
        descriptionLabel.text = ""
        heroImageView.image = nil
        spinner.startAnimating()
    }
    
    private func renderError(_ reason: String) {
        spinner.stopAnimating()
        titleLabel.text = ""
        descriptionLabel.text = ""
        heroImageView.image = nil
    }
    
    private func renderSuccess(){
        titleLabel.text = hero.name
        descriptionLabel.text = hero.description
        heroImageView.setImage(hero.photo)
        spinner.stopAnimating()
    }
    



}
