//
//  TagsFormViewModel.swift
//  NewsApp
//
//  Created by Sebastian Maludziński on 13/02/2022.
//

import Foundation
import RxSwift
import RxRelay

final class TagsFormViewModel {
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
    
    func addTag(_ tag: String) {
        let tag = tag.lowercased().capitalized
        let newTags = userSettings.value.tags + [tag]
        saveSettings(name: userSettings.value.name, tags: newTags)
    }
    
    func removeTag(_ index: Int) {
        var newTags = userSettings.value.tags
        newTags.remove(at: index)
        saveSettings(name: userSettings.value.name, tags: newTags)
    }
    
    private func saveSettings(name: String, tags: [String]) {
        let newSettings = UserSettings(name: name, tags: tags)
        Storage.shared.saveUserSettings(newSettings)
    }
}
