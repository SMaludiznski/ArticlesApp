//
//  HomeViewController.swift
//  NewsApp
//
//  Created by Sebastian Maludziński on 07/02/2022.
//

import UIKit
import RxCocoa
import RxSwift

final class HomeViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private let vm = HomeViewModel()
    var coordinator: HomeFlow?
    
    private lazy var mainStack = DefaultVerticalStack()
    private lazy var articlesContainer = DefaultVerticalStack()
    
    private lazy var header = HeaderViewController()
    private lazy var tagSearchBar = TagsSearchViewController()
    private lazy var articlesView = ArticlesViewController()
    
    override func loadView() {
        super.loadView()
        setupView()
    }
    
    private func setupView() {
        bindUI()
        setupChildView(header)
        setupChildView(tagSearchBar)
        setupChildView(articlesView)
        
        view.backgroundColor = .backgroundColor
        navigationController?.navigationBar.isHidden = true
        
        view.addSubview(mainStack)
        mainStack.addArrangedSubview(header.view)
        mainStack.addArrangedSubview(tagSearchBar.view)
        
        view.addSubview(articlesContainer)
        articlesContainer.addArrangedSubview(articlesView.view)
        
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            mainStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            articlesContainer.topAnchor.constraint(equalTo: mainStack.bottomAnchor, constant: 10),
            articlesContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            articlesContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            articlesContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            header.view.heightAnchor.constraint(equalToConstant: 50),
            tagSearchBar.view.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

//MARK: - Bind Ui
extension HomeViewController {
    private func bindUI() {
        
        vm.userSettings
            .subscribe(onNext: { [weak self] settings in
                self?.header.setupHellowMessage(with: settings.name)
                self?.tagSearchBar.view.isHidden = settings.tags.count == 0 ? true : false
            })
            .disposed(by: disposeBag)
        
        tagSearchBar.collectionView.rx.itemSelected
            .subscribe(onNext: { [weak self] item in
                if let keyWord = self?.vm.userSettings.value.tags[item.row] {
                    self?.articlesView.selectedTag(with: keyWord)
                }
            })
            .disposed(by: disposeBag)
        
        articlesView.collectionView.rx.itemSelected
            .subscribe(onNext: { [weak self] item in
                if let article = self?.articlesView.articleSelected(index: item) {
                    self?.coordinator?.startHomeFlow(with: article)
                }
            })
            .disposed(by: disposeBag)
    }
}
