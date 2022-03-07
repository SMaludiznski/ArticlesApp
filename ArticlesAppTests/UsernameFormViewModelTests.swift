//
//  UsernameFormViewModel.swift
//  ArticlesAppTests
//
//  Created by Sebastian Maludziński on 17/02/2022.
//

import XCTest
import RxSwift
import RxRelay
@testable import ArticlesApp

class UsernameFormViewModelTests: XCTestCase {
    
    func test_userSettingsSaving_includesAddingName() {
        let sut = UsernameFormViewModel()
        let userSettings = UserSettingsSpy(sut.userSettings)
        
        sut.saveName("George")
        XCTAssertEqual(userSettings.settings.name, "George")
        
        sut.saveName("Mike")
        XCTAssertEqual(userSettings.settings.name, "Mike")
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
