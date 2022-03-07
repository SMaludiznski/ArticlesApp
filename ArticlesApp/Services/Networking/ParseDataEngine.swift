//
//  ParseDataEngine.swift
//  NewsApp
//
//  Created by Sebastian Maludziński on 13/02/2022.
//

import Foundation

final class ParseDataEngine {
    
    static func parseData<T: Decodable>(_ data: Data) throws -> T {
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return decodedData
        } catch {
            throw NetworkingErrors.decodingError
        }
        
    }
}
