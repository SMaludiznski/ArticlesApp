//
//  DeafultButton.swift
//  NewsApp
//
//  Created by Sebastian Maludziński on 07/02/2022.
//

import UIKit

final class DeafultButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.backgroundColor = .accentColor
        self.setTitleColor(.white, for: .normal)
        self.clipsToBounds = true
        self.layer.cornerRadius = 12
        self.imageView?.tintColor = .white
    }
    
    func configureButtonTitle(with name: String) {
        self.setTitle(name, for: .normal)
    }
    
    func configureButtonImage(with imageName: String) {
        if let image = UIImage(systemName: imageName) {
            self.setImage(image, for: .normal)
        }
    }
    
}
