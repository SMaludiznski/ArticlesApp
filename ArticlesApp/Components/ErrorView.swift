//
//  ErrorViewController.swift
//  NewsApp
//
//  Created by Sebastian Maludziński on 15/02/2022.
//

import UIKit
import RxCocoa

final class ErrorView: UIView {
    private lazy var mainStack = DefaultVerticalStack()
    private lazy var imageStack = DefaultHorizontalStack()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Nothing here"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.textColor = .secondaryFontColor
        return label
    }()
    
    private lazy var errorImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "xmark.circle")
        image.tintColor = .secondaryFontColor
        return image
    }()
    
    private lazy var errorText: UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.textColor = .secondaryFontColor
        text.font = .systemFont(ofSize: 20, weight: .light)
        text.textAlignment = .center
        text.numberOfLines = 0
        return text
    }()
    
    lazy var refreshButton = DeafultButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        refreshButton.configureButtonTitle(with: "Refresh")
        mainStack.spacing = 30
        
        self.addSubview(mainStack)
        mainStack.addArrangedSubview(titleLabel)
        mainStack.addArrangedSubview(errorText)
        mainStack.addArrangedSubview(imageStack)
        
        imageStack.addArrangedSubview(UIView())
        imageStack.addArrangedSubview(errorImage)
        imageStack.addArrangedSubview(UIView())
        mainStack.addArrangedSubview(refreshButton)
        
        NSLayoutConstraint.activate([
            mainStack.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7),
            mainStack.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            mainStack.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            errorImage.widthAnchor.constraint(equalToConstant: 100),
            errorImage.heightAnchor.constraint(equalToConstant: 100),
            errorImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            refreshButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configureError(with error: Error) {
        errorText.text = error.localizedDescription
    }
}
