//
//  Comic.swift
//  Comic
//
//  Created by Yhondri Acosta Novas on 15/8/21.
//

import Foundation

struct Comic: Decodable {
    let id: Int64
    let title: String
    let thumbnail: Thumbnail
    let description: String?
}
