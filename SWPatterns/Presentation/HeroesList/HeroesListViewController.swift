//
//  HeroesListViewController.swift
//  SWPatterns
//
//  Created by Kevin Heredia on 2/10/24.
//

import UIKit

class HeroesListViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var errorContainer: UIStackView!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var spinner: UIActivityIndicatorView!
    @IBOutlet private weak var errorLabel: UILabel!
    
    private let viewModel: HeroesListViewModel
    
    init(viewModel: HeroesListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "HeroesListViewController", bundle: Bundle(for: type(of: self)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(HeroTableViewCell.nib, forCellReuseIdentifier: HeroTableViewCell.reuseIdentifier)
        bind()
        viewModel.load()
    }
    
    
    @IBAction func onRetryTapped(_ sender: UIButton) {
    }
    

    //MARK: - States
    private func bind(){
        viewModel.onStateChanged.bind { [weak self] state in
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
    
    
    private func renderError(_ reason: String){
        spinner.stopAnimating()
        errorContainer.isHidden = false
        tableView.isHidden = true
        errorLabel.text = reason
    }
    
    private func renderLoading(){
        spinner.startAnimating()
        errorContainer.isHidden = true
        tableView.isHidden = false
    }
    
    private func renderSuccess(){
        spinner.stopAnimating()
        errorContainer.isHidden = true
        tableView.isHidden = false
        tableView.reloadData()
    }
    
}

// MARK: - UITableViewDataSource - UITableViewDelegate
extension HeroesListViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.heroes.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        90
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HeroTableViewCell.reuseIdentifier, for: indexPath)
        if let cell = cell as? HeroTableViewCell{
            let hero = viewModel.heroes[indexPath.row]
            cell.setAvatar(hero.photo)
            cell.setHeroname(hero.name)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("holiwi")
    }
    
}
