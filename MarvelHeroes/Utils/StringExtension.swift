//
//  StringExtension.swift
//  MarvelHeroes
//
//  Created by Yhondri Acosta Novas on 6/8/21.
//

import Foundation
import CryptoKit

//Code from: https://stackoverflow.com/a/56578995/5337094

extension String {
    var md5Value: String {
        let digest = Insecure.MD5.hash(data: self.data(using: .utf8) ?? Data())
        return digest.map {
            String(format: "%02hhx", $0)
        }.joined()
    }
    
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}

struct LocalizedKey {
    //MARK: - General
    static let ups = "ups"
    static let acept = "acept"
    static let noDescription = "no_description"
    
    //MARK: - FavoriteListView
    static let favorites = "favoritelistview_favorites"
    static let favoritelistviewEmptyList = "favoritelistview_empty_list"

    //MARK: - CharactersListView
    static let characters = "characterlistview_characters"
    static let characterlistviewEmptyList = "characterlistview_empty_list"
    static let characterListViewErrorLoadingCharacters = "characterlistview_error_loading_characters"
    static let characterListViewLoadMore = "characterlistview_load_more"
    static let characterListViewCredentials = "characterlistview_credentials"
    static let characterListViewCredentialsMessage = "characterlistview_credentials_message"
    static let characterListViewPublicApiKey = "characterlistview_public_apikey"
    static let characterListViewPrivateApiKey = "characterlistview_private_apikey"
    static let characterListViewApiKeyErrorMessage = "characterlistview_apikey_error_message"
    
    // MARK: - CharacterDetailViewController
    static let characterDetailViewErrorLoadingCharacters = "characterDetailViewController_error_loading_characters"
}
