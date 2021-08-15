//
//  ComicListData.swift
//  ComicListData
//
//  Created by Yhondri Acosta Novas on 15/8/21.
//

import Foundation

struct ComicListData: Decodable {
    let total: Int
    let comics: [Comic]
    
    fileprivate enum CodingKeys: String, CodingKey {
        case total
        case comics = "results"
    }
}
