//
//  DownloadingStates.swift
//  NewsApp
//
//  Created by Sebastian Maludziński on 17/02/2022.
//

import Foundation

enum DownloadingStates {
    case success
    case failure(error: Error)
    case loading
}
