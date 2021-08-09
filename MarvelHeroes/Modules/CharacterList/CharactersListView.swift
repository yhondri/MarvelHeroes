//
//  CharactersListView.swift
//  MarvelHeroes
//
//  Created by Yhondri Acosta Novas on 6/8/21.
//

import UIKit

class CharactersListView: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var apiKeyDialogView: UIView!
    @IBOutlet weak var apiKeyDialogTitleLabel: UILabel!
    @IBOutlet weak var publicApiKeyTextField: UITextField!
    @IBOutlet weak var privateApiKeyTextField: UITextField!
    @IBOutlet weak var apiKeyErrorLabel: UILabel!
    @IBOutlet weak var apiKeyAceptButton: UIButton!
    @IBOutlet weak var credentialsMessage: UILabel!
    
    private let presenter: CharacterListPresentation
    private lazy var characters: [Character] = [Character]()
    private let cellIdentifier = "CharacterTVCell"
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
        self.title = LocalizedKey.characters.localized
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = true
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 60
        tableView.register(UINib(nibName: "CharacterTVCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: loadMorCellIdentifier)
        tableView.backgroundColor = .backgroundColor
        
        setupApiKeyDialog()
        showApiKeysDialog()
    }
    
    private func setupApiKeyDialog() {
        apiKeyDialogTitleLabel.text = LocalizedKey.characterListViewCredentials.localized
        credentialsMessage.text = LocalizedKey.characterListViewCredentialsMessage.localized
        publicApiKeyTextField.placeholder = LocalizedKey.characterListViewPublicApiKey.localized
        privateApiKeyTextField.placeholder = LocalizedKey.characterListViewPrivateApiKey.localized
        apiKeyAceptButton.setTitle(LocalizedKey.acept.localized, for: .normal)
    }
    
    @IBAction func onDidInsertKeys(_ sender: Any) {
        guard let publicKey = publicApiKeyTextField.text,
              let privateKey = privateApiKeyTextField.text,
              !publicKey.isEmpty,
              !privateKey.isEmpty else {
            apiKeyErrorLabel.text = LocalizedKey.characterListViewApiKeyErrorMessage.localized
            self.apiKeyErrorLabel.isHidden = false
            return
        }
        
        presenter.onInsertApiKeys(publicKey: publicKey, privateKey: privateKey)
        presenter.onLoadData()
    }
    
    private func showApiKeysDialog() {
        self.apiKeyErrorLabel.isHidden = true
        UIView.animate(withDuration: 0.25) {
            self.apiKeyDialogView.alpha = 1
        }
    }
}

// MARK: - CharacterListPresentation
extension CharactersListView: CharacterListViewP {
    func onDidLoadCharacters(_ newCharacters: [Character]) {
        guard !newCharacters.isEmpty else {
            return
        }
        
        DispatchQueue.main.async {
            guard !self.characters.isEmpty else {
                self.characters.append(contentsOf: newCharacters)
                self.tableView.reloadData()
                return
            }
            
            let oldLastIndex = self.characters.count
            let newLastIndex = (self.characters.count + newCharacters.count - 1)
            self.characters.append(contentsOf: newCharacters)
            self.tableView.beginUpdates()
            let newRowsIndexPaths = Array(oldLastIndex...newLastIndex).map { IndexPath(row: $0, section: 0) }
            self.tableView.insertRows(at: newRowsIndexPaths, with: .top)
            self.tableView.endUpdates()
        }
    }
    
    func showErrorLoadingData() {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: LocalizedKey.ups.localized,
                                                    message: LocalizedKey.characterListViewErrorLoadingCharacters.localized,
                                                    preferredStyle: .alert)
            let aceptAction = UIAlertAction(title: LocalizedKey.acept, style: .default, handler: nil)
            alertController.addAction(aceptAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func changeLoadingViewVisibility(isHidden: Bool) {
        DispatchQueue.main.async {
            if isHidden {
                self.hideSpinner()
            } else {
                self.showSpinner(onView: self.navigationController!.view)
            }
        }
    }
    
    func hideApiKeysDialog() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.25) {
                self.apiKeyDialogView.alpha = 0
            }
        }
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
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CharacterTVCell
            cell.character = characters[indexPath.row]
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
