//
//  DeafultHorizontalStack.swift
//  NewsApp
//
//  Created by Sebastian Maludziński on 08/02/2022.
//

import UIKit

final class DefaultHorizontalStack: UIStackView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.spacing = 15
    }
}
