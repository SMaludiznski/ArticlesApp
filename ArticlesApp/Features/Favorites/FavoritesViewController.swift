//
//  SearchViewController.swift
//  NewsApp
//
//  Created by Sebastian Maludziński on 07/02/2022.
//

import UIKit
import RxSwift
import RxCocoa

final class FavoritesViewController: UIViewController, UICollectionViewDelegateFlowLayout {
    var coordinator: FavoritesFlow?
    private let disposeBag = DisposeBag()
    private let vm = FavoritesViewModel(databaseService: RealmService())
    
    private lazy var mainStack = DefaultVerticalStack()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 25
        layout.minimumLineSpacing = 30
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    
    private lazy var tableView = UITableView()
    
    override func loadView() {
        super.loadView()
        setupView()
    }
    
    private func setupView() {
        bindUI()
        setupCollectionView()
        self.tapAroundToDissmisKeyboard()
        
        view.backgroundColor = .backgroundColor
        navigationController?.navigationBar.isHidden = true
        
        view.addSubview(mainStack)
        mainStack.addArrangedSubview(collectionView)
        
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            mainStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            mainStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupCollectionView() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(ArticleCell.self, forCellWithReuseIdentifier: ArticleCell.identifier)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .backgroundColor
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        return CGSize(width: width, height: 100)
    }
}

//MARK: -Bind UI
extension FavoritesViewController {
    private func bindUI() {
        vm.articles.asObservable()
            .bind(to: collectionView.rx.items(cellIdentifier: ArticleCell.identifier, cellType: ArticleCell.self)) { row, article, cell in
                cell.configureCell(with: article)
            }
            .disposed(by: disposeBag)

        collectionView.rx.itemSelected
            .subscribe(onNext: { [weak self] index in
                if let article = self?.vm.articles.value[index.row] {
                    self?.coordinator?.startSearchFlow(with: article)
                }
            })
            .disposed(by: disposeBag)

        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
        
        vm.databaseError
            .subscribe(onNext: { [weak self] errorMessage in
                self?.showError(message: errorMessage)
            })
            .disposed(by: disposeBag)
    }
}
