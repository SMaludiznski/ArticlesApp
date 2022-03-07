//
//  UsernameFormViewController.swift
//  NewsApp
//
//  Created by Sebastian Maludziński on 12/02/2022.
//

import UIKit
import RxSwift
import RxCocoa

final class UsernameFormViewController: UIViewController {
    private let disposeBag = DisposeBag()
    let vm = UsernameFormViewModel()
    
    private lazy var mainStack = DefaultHorizontalStack()
    lazy var nameField = DefaultTextField()
    lazy var saveButton = DeafultButton()
    
    override func loadView() {
        super.loadView()
        setupView()
    }
    
    private func setupView() {
        bindUI()
        
        view.addSubview(mainStack)
        mainStack.addArrangedSubview(nameField)
        mainStack.addArrangedSubview(saveButton)
        
        nameField.configureTextField(placeholder: "Username")
        saveButton.configureButtonTitle(with: "Save")
        
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: view.topAnchor),
            mainStack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainStack.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            saveButton.widthAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    private func bindUI() {
        vm.userSettings
            .subscribe(onNext: { [weak self] settings in
                self?.nameField.text = settings.name
            })
            .disposed(by: disposeBag)
        
        saveButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.saveName()
            })
            .disposed(by: disposeBag)
        
        nameField.rx.controlEvent(.editingDidEndOnExit)
            .subscribe(onNext: { [weak self] in
                self?.saveName()
            })
            .disposed(by: disposeBag)
    }
    
    private func saveName() {
        if let name = self.nameField.text {
            self.vm.saveName(name)
        }
    }
}
