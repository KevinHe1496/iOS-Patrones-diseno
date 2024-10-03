//
//  HeroTableViewCell.swift
//  SWPatterns
//
//  Created by Kevin Heredia on 2/10/24.
//

import UIKit

final class HeroTableViewCell: UITableViewCell {
    
 
    static let reuseIdentifier = "HeroTableViewCell"
    static var nib: UINib {
        UINib(nibName: "HeroTableViewCell", bundle: Bundle(for: HeroTableViewCell.self))
    }
    
    @IBOutlet weak var heroName: UILabel!
    
    @IBOutlet weak var avatar: AsyncImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatar.cancel()
    }
    
    func setAvatar(_ avatar: String) {
        self.avatar.setImage(avatar)
    }
    
    func setHeroname(_ heroName: String) {
        self.heroName.text = heroName
    }
    
}
