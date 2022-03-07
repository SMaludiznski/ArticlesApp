//
//  UsernameFormViewModel.swift
//  NewsApp
//
//  Created by Sebastian Maludziński on 13/02/2022.
//

import Foundation
import RxSwift
import RxRelay

final class UsernameFormViewModel {
    private let storage = Storage.shared
    private let disposeBag = DisposeBag()
    let userSettings = BehaviorRelay<UserSettings>(value: UserSettings(name: "", tags: []))
    
    init() {
        subscribe()
    }
    
    private func subscribe() {
        storage.currentUserSettings()
            .subscribe(onNext: { settings in
                if let settings = settings {
                    self.userSettings.accept(settings)
                }
            })
            .disposed(by: disposeBag)
    }
    
    func saveName(_ name: String) {
        let newSettings = UserSettings(name: name, tags: userSettings.value.tags)
        storage.saveUserSettings(newSettings)
    }
}
