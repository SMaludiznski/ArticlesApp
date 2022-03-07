//
//  SettingsViewModel2Tests.swift
//  NewsAppTests
//
//  Created by Sebastian Maludziński on 10/02/2022.
//
//
import XCTest
import RxSwift
import RxRelay
@testable import ArticlesApp

class SettingsViewModelTests: XCTestCase {
    
    func test_userSettingsSaving_includesAddingTag() {
        let sut = TagsFormViewModel()
        let userSettings = UserSettingsSpy(sut.userSettings)
        
        var savedTags: [String] = []
        Storage.shared.currentUserSettings()
            .subscribe(onNext: { settings in
                if let tags = settings?.tags {
                    savedTags = tags
                }
            })
            .dispose()
        
        sut.addTag("Book")
        savedTags += ["Book"]
        
        XCTAssertEqual(userSettings.settings.tags, savedTags)
    }
    
    func test_userSettingsSaving_includesRemovingTag() {
        let sut = TagsFormViewModel()
        let userSettings = UserSettingsSpy(sut.userSettings)
        
        var savedTags: [String] = []
        Storage.shared.currentUserSettings()
            .subscribe(onNext: { settings in
                if let tags = settings?.tags {
                    savedTags = tags
                }
            })
            .dispose()
        
        sut.addTag("TestTagToRemove")
        savedTags += ["TestTagToRemove".lowercased().capitalized]
        
        sut.removeTag(0)
        savedTags.remove(at: 0)
        
        XCTAssertEqual(userSettings.settings.tags, savedTags)
    }
    
    class UserSettingsSpy {
        private let disposeBag = DisposeBag()
        private(set) var settings = UserSettings(name: "", tags: [])
        
        init(_ observable: BehaviorRelay<UserSettings>) {
            observable
                .subscribe(onNext: { settings in
                    self.settings = settings
                })
                .disposed(by: disposeBag)
        }
    }
}
