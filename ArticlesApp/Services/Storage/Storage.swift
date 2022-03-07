//
//  Storage.swift
//  NewsApp
//
//  Created by Sebastian Maludziński on 09/02/2022.
//

import Foundation
import RxSwift

final class Storage {
    static let shared = Storage()
    private init() {}
    
    func saveUserSettings(_ settings: UserSettings) {
        do {
            let encodedData = try JSONEncoder().encode(settings)
            UserDefaults.standard.set(encodedData, forKey: Constants.userSettingsIdentifier)
        } catch {
            print("Error while settings encoding!")
        }
    }
    
    var currentUserSettings: () -> Observable<UserSettings?> = {
        return UserDefaults.standard.rx.observe(Data.self, Constants.userSettingsIdentifier)
            .map {
                $0.flatMap { try? JSONDecoder().decode(UserSettings.self, from: $0) }
            }
            .distinctUntilChanged()
    }
}
