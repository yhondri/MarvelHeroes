//
//  ComicsListResponse.swift
//  ComicsListResponse
//
//  Created by Yhondri Acosta Novas on 15/8/21.
//

import Foundation

struct ComicsListResponse: Decodable {
    let etag: String
    let data: ComicListData
}
