//
//  NewsAppTests.swift
//  NewsAppTests
//
//  Created by Sebastian Maludziński on 07/02/2022.
//

import XCTest
import RxSwift
@testable import ArticlesApp

class StorageTests: XCTestCase {
    let disposeBag = DisposeBag()
    
    func test_saveUserSettingsInUserDefaults() {
        var userSettings: UserSettings? = nil
        
        let settings = UserSettings(name: "Kamil", tags: ["Books", "Bitcoin"])
        Storage.shared.saveUserSettings(settings)
        
        Storage.shared.currentUserSettings()
            .subscribe(onNext: { value in
                userSettings = value
            })
            .disposed(by: disposeBag)
        
        XCTAssertEqual(userSettings, settings)
        resetTestUserSettings()
    }
    
    private func resetTestUserSettings() {
        let testSettings = UserSettings(name: "Test", tags: ["Test", "Test"])
        Storage.shared.saveUserSettings(testSettings)
    }
}
