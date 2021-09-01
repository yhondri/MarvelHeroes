//
//  CharacterListInteractor.swift
//  MarvelHeroes
//
//  Created by Yhondri Acosta Novas on 6/8/21.
//

import Foundation
import UIKit

class CharacterListInteractor: CharacterListInteractorInput {
    
    weak var output: CharacterListInteractorOutput?
    var didSuccessFirstLoading = false
    let apiRepository: ApiRepository
    var moduleType: ModuleType
    lazy var characters: [Character] = []
    private var didLoadCharacters: Bool = false
    var favoriteIds: Set<Int64> {
        apiRepository.getFavoriteIds()
    }

    init(apiRepository: ApiRepository, moduleType: ModuleType) {
        self.apiRepository = apiRepository
        self.moduleType = moduleType
    }
    
    func loadData() {
        if moduleType == .favoriteList {
            characters = apiRepository.getFavorites()
            output?.reloadTableView()
            setupNoDataLabelVisibility()
        } else {
            loadCharacters()
        }
    }
    
    func onSelectFavorite(character: Character, indexPath: IndexPath) {
        apiRepository.onSelectFavorite(character: character)
        
        if moduleType == .favoriteList {
            characters.remove(at: indexPath.row)
            output?.removeCellAt(indexPath)
        } else {
            output?.reloadTableView()
        }
        
        setupNoDataLabelVisibility()
    }
    
    private func setupNoDataLabelVisibility() {
        if characters.isEmpty {
            output?.showNoDataLabel(message: LocalizedKey.favoritelistviewEmptyList.localized)
        } else {
            output?.hideNoDataLabel()
        }
    }
    
    func handleSuccess(newCharacters: [Character]) {
        guard !characters.isEmpty else {
            characters.append(contentsOf: newCharacters)
            DispatchQueue.main.async {
                self.output?.reloadTableView()
            }
            return
        }
        
        let oldLastIndex = self.characters.count
        let newLastIndex = (self.characters.count + newCharacters.count - 1)
        characters.append(contentsOf: newCharacters)
        let newRowsIndexPaths = Array(oldLastIndex...newLastIndex).map { IndexPath(row: $0, section: 0) }

        DispatchQueue.main.async {
            self.output?.onDidLoadCharacters(self.characters, newRowsIndexPaths: newRowsIndexPaths)
            if !self.didLoadCharacters {
                self.didLoadCharacters = true
            }
            self.output?.reloadTableView()
        }
    }
    
    
    func showError() {
        DispatchQueue.main.async {
            self.output?.onErrorLoadingCharacters()
        }
    }
}


