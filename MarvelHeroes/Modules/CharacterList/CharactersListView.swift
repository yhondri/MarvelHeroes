//
//  CharactersListView.swift
//  MarvelHeroes
//
//  Created by Yhondri Acosta Novas on 6/8/21.
//

import UIKit

class CharactersListView: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noDataLabel: UILabel!
    
    private let presenter: CharacterListPresentation
    private let loadMorCellIdentifier = "loadMorCellIdentifier"
    
    init(presenter: CharacterListPresentation) {
        self.presenter = presenter
        super.init(nibName: "CharactersListView", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = true
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 60
        tableView.register(CharacterTVCell.nib(), forCellReuseIdentifier: CharacterTVCell.cellIdentifier)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: loadMorCellIdentifier)
        tableView.backgroundColor = .backgroundColor
        
        if presenter.moduleType == .favoriteList {
            self.title = LocalizedKey.favorites.localized
            presenter.showCredentialsView()
        } else {
            self.title = LocalizedKey.characters.localized
            presenter.loadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if presenter.moduleType == .favoriteList {
            presenter.loadData()
        }
        tableView.reloadData()
    }
}

// MARK: - CharacterListPresentation
extension CharactersListView: CharacterListViewP {
    func onDidLoadCharacters(_ characters: [Character], newRowsIndexPaths: [IndexPath]) {
        tableView.beginUpdates()
        tableView.insertRows(at: newRowsIndexPaths, with: .top)
        tableView.endUpdates()
    }
    
    func reloadTableView() {
        tableView.reloadData()
    }
    
    func showErrorLoadingData() {
        let alertController = UIAlertController(title: LocalizedKey.ups.localized,
                                                message: LocalizedKey.characterListViewErrorLoadingCharacters.localized,
                                                preferredStyle: .alert)
        let aceptAction = UIAlertAction(title: LocalizedKey.acept, style: .default, handler: nil)
        alertController.addAction(aceptAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showLoadingView() {
        showSpinner(onView: self.navigationController!.view)
    }
    
    func hideLoadingView() {
        hideSpinner()
    }
    
    func reloadCellAt(_ indexPath: IndexPath) {
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    //Favorites
    func removeCellAt(_ indexPath: IndexPath) {
        tableView.beginUpdates()
        tableView.deleteRows(at: [indexPath], with: .automatic)
        tableView.endUpdates()
    }
    
    func showNoDataLabel(message: String) {
        noDataLabel.text = message
        noDataLabel.isHidden = false
    }
    
    func hideNoDataLabel() {
        noDataLabel.isHidden = true
    }
}

// MARK: - UITableViewDataSource
extension CharactersListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if presenter.moduleType == .favoriteList {
            return presenter.characters.count
        } else {
            return presenter.characters.count + 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if presenter.moduleType == .characterList && indexPath.row == presenter.characters.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: loadMorCellIdentifier, for: indexPath)
            cell.textLabel?.text = LocalizedKey.characterListViewLoadMore.localized
            cell.textLabel?.textAlignment = .center
            cell.backgroundColor = .clear
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: CharacterTVCell.cellIdentifier, for: indexPath) as! CharacterTVCell
            let character = presenter.characters[indexPath.row]
            cell.character = character
            cell.isFavorite = presenter.favoriteIds.contains(character.id)
            if let delegate = presenter as? CharacterTVCellDelegate {
                cell.delegate = delegate
            }
            cell.selectionStyle = .none
            return cell
        }
    }
}

// MARK: - UITableViewDataSource
extension CharactersListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if presenter.moduleType == .characterList && indexPath.row == presenter.characters.count {
            return 60
        } else {
            return 150
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if presenter.moduleType == .characterList && indexPath.row == presenter.characters.count {
            presenter.loadData()
        } else {
            presenter.onShowCharacterDetail(presenter.characters[indexPath.row])
        }
    }
}
