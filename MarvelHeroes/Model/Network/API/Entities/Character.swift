//
//  Character.swift
//  Character
//
//  Created by Yhondri Acosta Novas on 15/8/21.
//

import Foundation

struct Character: Decodable {
    let id: Int64
    let name: String
    let description: String?
    let thumbnail: Thumbnail
    var isFavorite: Bool = false
    
    fileprivate enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case thumbnail
    }
}
