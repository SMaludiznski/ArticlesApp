//
//  SettingsViewController.swift
//  NewsApp
//
//  Created by Sebastian Maludziński on 07/02/2022.
//

import UIKit
import RxSwift
import RxCocoa

final class SettingsViewController: UIViewController, UICollectionViewDelegateFlowLayout {
    var coordinator: Coordinator?
    
    private lazy var mainStack = DefaultVerticalStack()
    private lazy var usernameForm = UsernameFormViewController()
    private lazy var tagsForm = TagsFormViewController()
    
    override func loadView() {
        super.loadView()
        setupView()
    }
    
    private func setupView() {
        setupChildView(usernameForm)
        setupChildView(tagsForm)
        
        self.tapAroundToDissmisKeyboard()
        view.backgroundColor = .backgroundColor
        navigationController?.navigationBar.isHidden = true
        
        view.addSubview(mainStack)
        mainStack.addArrangedSubview(usernameForm.view)
        mainStack.addArrangedSubview(tagsForm.view)
        
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            mainStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            mainStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
