//
//  FavoritesViewController.swift
//  MarvelHeroes
//
//  Created by Yhondri Acosta Novas on 24/8/21.
//

import UIKit

class FavoriteListView: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noFavoritesLabel: UILabel!
    
    private lazy var favorites: [Character] = [Character]()
    private let presenter: FavoritePresentation
    let cellIdentifier = "CharacterTVCell"

    init(presenter: FavoritePresentation) {
        self.presenter = presenter
        super.init(nibName: "FavoriteListView", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = LocalizedKey.favorites.localized
        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 60
        tableView.register(CharacterTVCell.nib(), forCellReuseIdentifier: CharacterTVCell.cellIdentifier)
        tableView.backgroundColor = .backgroundColor
        tableView.tableFooterView = UIView(frame: .zero)

        presenter.showCredentialsView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        favorites = presenter.favorites
        checkNoFavoritesLabelVisibility()
        tableView.reloadData()
    }
}

// MARK: - FavoriteListView
extension FavoriteListView: FavoriteListViewP {
    func removeCellAt(_ indexPath: IndexPath) {
        favorites.remove(at: indexPath.row)
        
        tableView.beginUpdates()
        tableView.deleteRows(at: [indexPath], with: .automatic)
        tableView.endUpdates()

        checkNoFavoritesLabelVisibility()
    }
    
    private func checkNoFavoritesLabelVisibility() {
        noFavoritesLabel.isHidden = !favorites.isEmpty
    }
}

// MARK: - UITableViewDataSource
extension FavoriteListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CharacterTVCell.cellIdentifier, for: indexPath) as! CharacterTVCell
        let character = favorites[indexPath.row]
        cell.character = character
        cell.isFavorite = presenter.favoriteIds.contains(character.id)
        if let delegate = presenter as? CharacterTVCellDelegate {
            cell.delegate = delegate
        }
        cell.selectionStyle = .none
        return cell
    }
}

// MARK: - UITableViewDelegate
extension FavoriteListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let character = favorites[indexPath.row]
        presenter.onShowCharacterDetail(character: character)
    }
}
