//
//  DeafultTextField.swift
//  NewsApp
//
//  Created by Sebastian Maludziński on 07/02/2022.
//

import UIKit

final class DefaultTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .white
        self.textColor = .darkGray
        self.clipsToBounds = true
        self.layer.cornerRadius = 12
        self.layer.borderColor = UIColor.accentColor?.cgColor
        self.layer.borderWidth = 0.4
        self.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 20))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func configureTextField(placeholder: String) {
        self.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
    }
}
