//
//  ArticlesViewController.swift
//  NewsApp
//
//  Created by Sebastian Maludziński on 11/02/2022.
//

import UIKit
import RxSwift

final class ArticlesViewController: UIViewController, UICollectionViewDelegateFlowLayout {
    private let disposeBag = DisposeBag()
    private let vm = ArticlesViewModel()
    
    private lazy var errorView = ErrorView()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 25
        layout.minimumLineSpacing = 30
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vm.fetchArticles()
    }
    
    override func loadView() {
        super.loadView()
        setupCollectionView()
        bindUI()
    }
    
    private func setupCollectionView() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(ArticleCell.self, forCellWithReuseIdentifier: ArticleCell.identifier)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .backgroundColor
    }
    
    func selectedTag(with keyWord: String) {
        vm.keyword = keyWord
        vm.fetchArticles()
    }
    
    func articleSelected(index: IndexPath) -> Article {
        return vm.articles.value[index.row]
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        return CGSize(width: width, height: 100)
    }
}

//MARK: - Bind UI
extension ArticlesViewController {
    private func bindUI() {
        vm.articles.asObservable()
            .bind(to: collectionView.rx.items(cellIdentifier: ArticleCell.identifier, cellType: ArticleCell.self)) { row, article, cell in
                cell.configureCell(with: article)
            }
            .disposed(by: disposeBag)
        
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
        
        vm.viewState
            .subscribe(onNext: { loadingState in
                DispatchQueue.main.async { [weak self] in
                    self?.viewSwitcher(loadingState)
                }
            })
            .disposed(by: disposeBag)
        
        errorView.refreshButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.vm.fetchArticles()
            })
            .disposed(by: disposeBag)
    }
    
    private func viewSwitcher(_ loadingState: DownloadingStates) {
        switch loadingState {
        case.success:
            self.view = self.collectionView
        case .failure(let error):
            self.errorView.configureError(with: error)
            self.view = self.errorView
        case .loading:
            self.view = LoadingView()
        }
    }
}
