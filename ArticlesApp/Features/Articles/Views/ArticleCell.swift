//
//  ArticleCell.swift
//  NewsApp
//
//  Created by Sebastian Maludziński on 11/02/2022.
//

import UIKit

final class ArticleCell: UICollectionViewCell {
    static let identifier: String = "ArticleCell"
    
    private lazy var mainStack = DefaultHorizontalStack()
    private lazy var articleInfoStack = DefaultVerticalStack()
    
    private lazy var articleImage: UIImageView = {
        let articleImage = UIImageView()
        articleImage.translatesAutoresizingMaskIntoConstraints = false
        articleImage.backgroundColor = .imageBackground
        articleImage.layer.cornerRadius = 10
        articleImage.clipsToBounds = true
        articleImage.layer.borderColor = UIColor.lightGray.cgColor
        articleImage.layer.borderWidth = 0.5
        return articleImage
    }()
    
    private lazy var articleTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.textColor = .secondaryFontColor
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var articleDetailInfo = DefaultHorizontalStack()
    private lazy var articleAuthor = ArticleInfoLabel()
    private lazy var articleDate = ArticleInfoLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        articleDate.textAlignment = .right
        
        contentView.addSubview(mainStack)
        mainStack.addArrangedSubview(articleImage)
        
        
        mainStack.addArrangedSubview(articleInfoStack)
        articleInfoStack.addArrangedSubview(articleTitle)
        articleInfoStack.addArrangedSubview(UIView())
        
        articleInfoStack.addArrangedSubview(articleDetailInfo)
        articleDetailInfo.addArrangedSubview(articleAuthor)
        articleDetailInfo.addArrangedSubview(articleDate)
        
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mainStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            articleImage.widthAnchor.constraint(equalToConstant: 110)
        ])
    }
    
    func configureCell(with article: Article) {
        var date = article.publishedAt
        articleTitle.text = article.title
        articleDate.text = date.articleDateFormatter()
        articleImage.loadImageFromURL(urlString: article.urlToImage)
        setAuthor(name: article.author)
    }
    
    private func setAuthor(name: String?) {
        if let author = name {
            if URL(string: author) == nil {
                self.articleAuthor.text = name
            }
        } else {
            self.articleAuthor.text = "Unknown"
        }
    }
}
