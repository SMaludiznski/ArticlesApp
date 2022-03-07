//
//  ArticleDetailViewController.swift
//  ArticlesApp
//
//  Created by Sebastian Maludziński on 17/02/2022.
//

import UIKit
import WebKit
import RxSwift

final class ArticleDetailViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private let vm = ArticleDetailViewModel(databaseService: RealmService())
    private var article: Article?
    
    private lazy var mainStack = DefaultVerticalStack()
    private lazy var webView = ArticleWebView()
    private lazy var buttonsStack = DefaultHorizontalStack()
    private lazy var goBackButton = DeafultButton()
    private lazy var likeArticleButton = DeafultButton()
    
    override func loadView() {
        super.loadView()
        setupView()
    }
    
    private func setupView() {
        bindUI()
        view.backgroundColor = .backgroundColor
        setupButtons()
        
        view.addSubview(mainStack)
        mainStack.addArrangedSubview(webView)
        mainStack.addArrangedSubview(buttonsStack)
        buttonsStack.addArrangedSubview(goBackButton)
        buttonsStack.addArrangedSubview(likeArticleButton)
        
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            mainStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            mainStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            
            goBackButton.heightAnchor.constraint(equalToConstant: 60),
            likeArticleButton.widthAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    private func setupButtons() {
        buttonsStack.spacing = 5
        goBackButton.setTitle("Go back", for: .normal)
        goBackButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        likeArticleButton.addTarget(self, action: #selector(likeArticle), for: .touchUpInside)
    }
    
    func configureView(with article: Article) {
        guard let url = URL(string: article.url) else {
            goBack()
            return
        }
        self.article = article
        
        vm.checkArticleLikeStatus(article)
        webView.webView.load(URLRequest(url: url))
    }
    
    @objc func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func likeArticle() {
        guard let article = self.article else {
            return
        }
        
        if vm.isArticleLiked.value {
            vm.removeArticleFromFavorites(article)
        } else {
            vm.addArticleToFavorites(article)
        }
    }
}

extension ArticleDetailViewController {
    private func bindUI() {
        vm.isArticleLiked.asObservable()
            .subscribe(onNext: { [weak self] value in
                if value {
                    self?.likeArticleButton.setImage(UIImage(systemName: "suit.heart.fill"), for: .normal)
                } else {
                    self?.likeArticleButton.setImage(UIImage(systemName: "suit.heart"), for: .normal)
                }
            })
            .disposed(by: disposeBag)
        
        vm.databaseError
            .subscribe(onNext: { [weak self] errorMessage in
                self?.showError(message: errorMessage)
            })
            .disposed(by: disposeBag)
    }
}
