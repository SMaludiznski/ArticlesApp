//
//  SearchTagCell.swift
//  NewsApp
//
//  Created by Sebastian Maludziński on 10/02/2022.
//

import UIKit

final class SearchTagCell: UICollectionViewCell {
    static let identifier: String = "SearchTagCell"
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.selectedCell()
            } else {
                self.unselectedCell()
            }
        }
    }
    
    private lazy var tagLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.textColor = .secondaryFontColor
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.addSubview(tagLabel)
        
        NSLayoutConstraint.activate([
            tagLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            tagLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            tagLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            tagLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    private func selectedCell() {
        self.tagLabel.textColor = .accentColor
    }
    
    private func unselectedCell() {
        self.tagLabel.textColor = .secondaryFontColor
    }
    
    func configureCell(with tag: String) {
        self.tagLabel.text = tag
    }
}
