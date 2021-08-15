//
//  CharacterListData.swift
//  CharacterListData
//
//  Created by Yhondri Acosta Novas on 15/8/21.
//

import Foundation

struct CharacterListData: Decodable {
    let total: Int
    let characters: [Character]
    
    fileprivate enum CodingKeys: String, CodingKey {
        case total
        case characters = "results"
    }
}
