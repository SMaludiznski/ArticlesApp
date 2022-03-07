//
//  RealmErrors.swift
//  ArticlesApp
//
//  Created by Sebastian Maludziński on 22/02/2022.
//

import Foundation

enum RealmErrors: LocalizedError {
    case dataBaseError
    case errorWithDataSaving
    case errorWithDataDeleting
    case errorWithGettingData
    
    var errorDescription: String? {
        switch self {
        case .dataBaseError:
            return NSLocalizedString("There is error with data base.", comment: "")
        case .errorWithDataSaving:
            return NSLocalizedString("The data could not be saved to the database.", comment: "")
        case .errorWithDataDeleting:
            return NSLocalizedString("The data could not be deleted to the database", comment: "")
        case .errorWithGettingData:
            return NSLocalizedString("The data could not be retrieved from the database.", comment: "")
        }
    }
}
