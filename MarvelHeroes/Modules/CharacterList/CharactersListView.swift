//
//  CharactersListView.swift
//  MarvelHeroes
//
//  Created by Yhondri Acosta Novas on 6/8/21.
//

import UIKit

class CharactersListView: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private let presenter: CharacterListPresentation
    private lazy var characters: [Character] = [Character]()
    private let loadMorCellIdentifier = "loadMorCellIdentifier"
    private var didLoadCharacters: Bool = false
    
    init(presenter: CharacterListPresentation) {
        self.presenter = presenter
        super.init(nibName: "CharactersListView", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = LocalizedKey.characters.localized
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = true
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 60
        tableView.register(CharacterTVCell.nib(), forCellReuseIdentifier: CharacterTVCell.cellIdentifier)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: loadMorCellIdentifier)
        tableView.backgroundColor = .backgroundColor
        presenter.onLoadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if didLoadCharacters {
            tableView.reloadData()
        }
    }
}

// MARK: - CharacterListPresentation
extension CharactersListView: CharacterListViewP {
    func onDidLoadCharacters(_ newCharacters: [Character]) {
        guard !newCharacters.isEmpty else {
            return
        }
        
        guard !characters.isEmpty else {
            characters.append(contentsOf: newCharacters)
            tableView.reloadData()
            didLoadCharacters = true
            return
        }
        
        let oldLastIndex = self.characters.count
        let newLastIndex = (self.characters.count + newCharacters.count - 1)
        characters.append(contentsOf: newCharacters)
        tableView.beginUpdates()
        let newRowsIndexPaths = Array(oldLastIndex...newLastIndex).map { IndexPath(row: $0, section: 0) }
        tableView.insertRows(at: newRowsIndexPaths, with: .top)
        tableView.endUpdates()
        didLoadCharacters = true
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
}

// MARK: - UITableViewDataSource
extension CharactersListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if characters.isEmpty {
            return 0
        }
        return characters.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == characters.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: loadMorCellIdentifier, for: indexPath)
            cell.textLabel?.text = LocalizedKey.characterListViewLoadMore.localized
            cell.textLabel?.textAlignment = .center
            cell.backgroundColor = .clear
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: CharacterTVCell.cellIdentifier, for: indexPath) as! CharacterTVCell
            let character = characters[indexPath.row]
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
        if indexPath.row == characters.count {
            return 60
        } else {
            return 150
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == characters.count {
            presenter.onLoadData()
        } else {
            presenter.onShowCharacterDetail(characters[indexPath.row])
        }
    }
}
