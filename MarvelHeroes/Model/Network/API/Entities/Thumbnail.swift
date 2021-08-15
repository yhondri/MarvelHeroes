//
//  Thumbnail.swift
//  Thumbnail
//
//  Created by Yhondri Acosta Novas on 15/8/21.
//

import Foundation

struct Thumbnail: Decodable {
    let path: String
    let imageExtension: String
    
    fileprivate enum CodingKeys: String, CodingKey {
        case path
        case imageExtension = "extension"
    }
    
    func getURL() -> URL? {
        return URL(string: String(format: "%@.%@", path, imageExtension))
    }
}

