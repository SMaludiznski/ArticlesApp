//
//  UIControllerView+Extensions.swift
//  NewsApp
//
//  Created by Sebastian Maludziński on 11/02/2022.
//

import Foundation
import UIKit
import RxCocoa

extension UIViewController {
    func tapAroundToDissmisKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func hideKeyboard() {
        self.view.endEditing(true)
    }
    
    func setupChildView(_ childView: UIViewController) {
        self.addChild(childView)
        childView.didMove(toParent: self)
    }
    
    func showError(message text: String) {
        let alertVc = UIAlertController(title: "Error", message: text, preferredStyle: .alert)
        alertVc.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(alertVc, animated: true)
    }
}
