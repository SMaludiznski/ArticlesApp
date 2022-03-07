//
//  LoadingView.swift
//  NewsApp
//
//  Created by Sebastian Maludziński on 15/02/2022.
//

import Foundation
import UIKit

final class LoadingView: UIView {
    lazy var loadingSpinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.color = .accentColor
        spinner.style = .large
        spinner.startAnimating()
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.addSubview(loadingSpinner)
        
        NSLayoutConstraint.activate([
            loadingSpinner.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            loadingSpinner.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}
