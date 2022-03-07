//
//  TagCell.swift
//  NewsApp
//
//  Created by Sebastian Maludziński on 08/02/2022.
//

import UIKit

final class TagCell: UICollectionViewCell {
    static let identifier: String = "TagCell"
    
    private lazy var cellContainer: UIView = {
        let cellContainer = UIView()
        cellContainer.translatesAutoresizingMaskIntoConstraints = false
        cellContainer.clipsToBounds = true
        cellContainer.layer.cornerRadius = 15
        cellContainer.layer.borderWidth = 0.5
        cellContainer.layer.borderColor = UIColor.lightGray.cgColor
        cellContainer.backgroundColor = .white
        return cellContainer
    }()
    
    private lazy var tagLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .white
        label.textAlignment = .center
        label.textColor = .darkGray
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
        contentView.addSubview(cellContainer)
        cellContainer.addSubview(tagLabel)
        
        NSLayoutConstraint.activate([
            cellContainer.topAnchor.constraint(equalTo: contentView.topAnchor),
            cellContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cellContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cellContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            tagLabel.topAnchor.constraint(equalTo: cellContainer.topAnchor, constant: 5),
            tagLabel.leadingAnchor.constraint(equalTo: cellContainer.leadingAnchor, constant: 10),
            tagLabel.trailingAnchor.constraint(equalTo: cellContainer.trailingAnchor, constant: -10),
            tagLabel.bottomAnchor.constraint(equalTo: cellContainer.bottomAnchor, constant: -5)
        ])
    }
    
    func configureCell(with tag: String) {
        self.tagLabel.text = tag
    }
}
