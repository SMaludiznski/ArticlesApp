//
//  HeaderViewController.swift
//  NewsApp
//
//  Created by Sebastian Maludziński on 11/02/2022.
//

import UIKit
import RxSwift
import RxCocoa

final class HeaderViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private let vm = HeaderViewModel()
    
    private lazy var mainStack = DefaultHorizontalStack()
    
    private lazy var welcomeMessageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 22, weight: .light)
        label.textColor = .fontColor
        return label
    }()
    
    private lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 40, weight: .ultraLight)
        label.textAlignment = .right
        label.textColor = .fontColor
        return label
    }()
    
    override func loadView() {
        super.loadView()
        setupView()
    }
    
    private func setupView() {
        bindUI()
        view.backgroundColor = .backgroundColor
        
        view.addSubview(mainStack)
        mainStack.addArrangedSubview(welcomeMessageLabel)
        mainStack.addArrangedSubview(temperatureLabel)
        
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: view.topAnchor),
            mainStack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainStack.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupWeather(with temp: Int) {
        DispatchQueue.main.async { [weak self] in
            self?.temperatureLabel.text = "\(temp)°C"
        }
    }
    
    func setupHellowMessage(with name: String) {
        let userName = name.isEmpty ? "there" : name
        
        let text = "Hello \(userName)! \nThis is your today's feed."
        let attributedText = NSMutableAttributedString(string: text)
        
        let fontSize = UIFont.systemFont(ofSize: 14)
        
        let loacation = 7 + userName.count
        attributedText.setAttributes([.font: fontSize], range: NSRange(location: loacation, length: text.count - loacation))
        welcomeMessageLabel.attributedText = attributedText
    }
}

//MARK: - Bind UI
extension HeaderViewController {
    private func bindUI(){
        vm.temperature
            .subscribe(onNext: { [weak self] temperature in
                self?.setupWeather(with: temperature)
            })
            .disposed(by: disposeBag)
    }
}
