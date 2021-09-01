//
//  CredentialsViewController.swift
//  MarvelHeroes
//
//  Created by Yhondri Acosta Novas on 25/8/21.
//

import UIKit

class CredentialsViewController: UIViewController {
    
    private lazy var publicKeyTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = LocalizedKey.characterListViewPublicApiKey.localized
        textField.borderStyle = .line
        textField.delegate = self
        return textField
    }()
    
    private lazy var privateKeyTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = LocalizedKey.characterListViewPrivateApiKey.localized
        textField.borderStyle = .line
        textField.delegate = self
        return textField
    }()
    
    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.text = LocalizedKey.characterListViewApiKeyErrorMessage.localized
        label.textColor = .red
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    private let presenter: CredentialsPresentation
    
    init(presenter: CredentialsPresentation) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    @objc private func onAcept() {
        view.endEditing(true)
        guard let publicKey = publicKeyTextField.text,
              let privateKey = privateKeyTextField.text,
              !publicKey.isEmpty,
              !privateKey.isEmpty else {
            UIView.animate(withDuration: 0.25) {
                self.errorLabel.isHidden = false
            }
            return
        }
        presenter.onInsertApiKeys(publicKey: publicKey, privateKey: privateKey)
    }
    
    private func setupUI() {
        view.backgroundColor = .backgroundColor
        
        let credentialContentView = UIView()
        credentialContentView.translatesAutoresizingMaskIntoConstraints = false
        credentialContentView.backgroundColor = .surface
        view.addSubview(credentialContentView)
        
        let titleLabel = UILabel()
        titleLabel.text = LocalizedKey.characterListViewCredentials.localized
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 50, weight: .black)
        let subtitleLabel = UILabel()
        subtitleLabel.text = LocalizedKey.characterListViewCredentialsMessage.localized
        subtitleLabel.numberOfLines = 0
        subtitleLabel.textAlignment = .center
        errorLabel.isHidden = true
        let aceptButton = UIButton(type: .system)
        aceptButton.setTitle(LocalizedKey.acept.localized, for: .normal)
        aceptButton.addTarget(self, action: #selector(onAcept), for: .touchUpInside)
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel, publicKeyTextField, privateKeyTextField, errorLabel, aceptButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 8
        credentialContentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            credentialContentView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            credentialContentView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            credentialContentView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: credentialContentView.leadingAnchor, constant: 8),
            stackView.topAnchor.constraint(equalTo: credentialContentView.topAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: credentialContentView.trailingAnchor, constant: -8),
            stackView.bottomAnchor.constraint(equalTo: credentialContentView.bottomAnchor, constant: -8),
        ])
    }
}

// MARK: - UITextFieldDelegate
extension CredentialsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        onAcept()
        return true
    }
}
