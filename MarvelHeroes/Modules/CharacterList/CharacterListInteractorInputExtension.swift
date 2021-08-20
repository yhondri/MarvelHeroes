//
//  CharacterListInteractorInputExtension.swift
//  CharacterListInteractorInputExtension
//
//  Created by Yhondri Acosta Novas on 20/8/21.
//

import Foundation

extension CharacterListInteractorInput {
    func handleSuccess(characters: [Character]) {
        self.output?.onDidLoadCharacters(characters)
        if !self.didSuccessFirstLoading && !characters.isEmpty {
            self.output?.onHideApiKeysDialog()
            self.didSuccessFirstLoading = true
        }
    }
}
