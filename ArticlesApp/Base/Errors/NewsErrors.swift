//
//  NewsErrors.swift
//  ArticlesApp
//
//  Created by Sebastian Maludziński on 17/02/2022.
//

import Foundation

enum NewsErrors: LocalizedError {
    case emptyResult
    case unknownError
    
    var errorDescription: String? {
        switch self {
        case .emptyResult:
            return NSLocalizedString("This keyword has not any articles!", comment: "")
        case .unknownError:
            return NSLocalizedString("Unknown error! Refresh or choose another keyword!", comment: "")
        }
    }
}
