//
//  ArticleInfoLabel.swift
//  NewsApp
//
//  Created by Sebastian Maludziński on 12/02/2022.
//

import UIKit

final class ArticleInfoLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.textColor = .secondaryFontColor
        self.font = .systemFont(ofSize: 15, weight: .light)
        self.numberOfLines = 0
    }
}
