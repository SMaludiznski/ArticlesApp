//
//  TagsFormViewController.swift
//  NewsApp
//
//  Created by Sebastian Maludziński on 12/02/2022.
//

import UIKit
import RxSwift

final class TagsFormViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private let vm = TagsFormViewModel()
    
    private lazy var mainStack = DefaultVerticalStack()
    private lazy var tagsFormStack = DefaultHorizontalStack()
    lazy var tagField = DefaultTextField()
    lazy var addTagButton = DeafultButton()
    
    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 8
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()

    override func loadView() {
        super.loadView()
        setupView()
    }
    
    private func setupView() {
        bindUI()
        setupCollectionView()
        
        tagField.configureTextField(placeholder: "New tag")
        addTagButton.configureButtonTitle(with: "Add")
        
        view.addSubview(mainStack)
        mainStack.addArrangedSubview(tagsFormStack)
        tagsFormStack.addArrangedSubview(tagField)
        tagsFormStack.addArrangedSubview(addTagButton)
        
        mainStack.addArrangedSubview(collectionView)
        
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            mainStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            addTagButton.widthAnchor.constraint(equalToConstant: 60),
        ])
    }
    
    private func setupCollectionView() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(TagCell.self, forCellWithReuseIdentifier: TagCell.identifier)
        collectionView.backgroundColor = .backgroundColor
    }
}

extension TagsFormViewController {
    private func bindUI() {
        vm.userSettings.asObservable()
            .map{ settings in
                return settings.tags
            }
            .bind(to: self.collectionView.rx.items(cellIdentifier: TagCell.identifier, cellType: TagCell.self)) { row, tag, cell in
                cell.configureCell(with: tag)
            }
            .disposed(by: disposeBag)
        
        collectionView.rx
            .itemSelected
            .subscribe(onNext: { [weak self] tag in
                self?.vm.removeTag(tag.item)
            })
            .disposed(by: disposeBag)
        
        addTagButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.addTag()
            })
            .disposed(by: disposeBag)
        
        tagField.rx.controlEvent(.editingDidEndOnExit)
            .subscribe(onNext: { [weak self] in
                self?.addTag()
            })
            .disposed(by: disposeBag)
    }
    
    private func addTag() {
        if let tag = self.tagField.text {
            self.tagField.text = ""
            
            if !tag.isEmpty {
                self.vm.addTag(tag)
            }
        }
    }
}
