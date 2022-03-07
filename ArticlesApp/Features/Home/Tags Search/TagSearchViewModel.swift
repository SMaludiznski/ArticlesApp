//
//  TagSearchViewModel.swift
//  NewsApp
//
//  Created by Sebastian Maludziński on 13/02/2022.
//

import Foundation
import RxSwift
import RxRelay

final class TagsSearchViewModel {
    private let disposeBag = DisposeBag()
    let userSettings = BehaviorRelay<UserSettings>(value: Constants.defaultUserSettings)
    
    init() {
        subscribeUserSettings()
    }
    
    private func subscribeUserSettings() {
        Storage.shared.currentUserSettings()
            .subscribe(onNext: { settings in
                if let settings = settings {
                    self.userSettings.accept(settings)
                }
            })
            .disposed(by: disposeBag)
    }
}
