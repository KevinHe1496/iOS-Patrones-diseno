//
//  Hero.swift
//  SWPatterns
//
//  Created by Kevin Heredia on 2/10/24.
//

import Foundation

struct Hero: Equatable, Decodable {
    let identifier: String
    let name: String
    let description: String
    let photo: String
    let favorite: Bool
    
    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case name
        case description
        case photo
        case favorite
        
        
        
    }
}
