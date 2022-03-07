//
//  TagSearchBar.swift
//  NewsApp
//
//  Created by Sebastian Maludziński on 08/02/2022.
//

import UIKit
import RxSwift

final class TagsSearchViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private let vm = TagsSearchViewModel()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 25
        layout.minimumInteritemSpacing = 25
        layout.scrollDirection = .horizontal
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
        
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupCollectionView() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(SearchTagCell.self, forCellWithReuseIdentifier: SearchTagCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .backgroundColor
    }
}

extension TagsSearchViewController {
    private func bindUI() {
        vm.userSettings.asObservable()
            .map { return $0.tags }
            .bind(to: collectionView.rx.items(cellIdentifier: SearchTagCell.identifier, cellType: SearchTagCell.self)) { row, tag, cell in
                cell.configureCell(with: tag)
            }
            .disposed(by: disposeBag)
    }
}
