//
//  NewsEndpoint.swift
//  NewsApp
//
//  Created by Sebastian Maludziński on 13/02/2022.
//

import Foundation

enum NewsEndpoint: Endpoint {
    case fetchNews(keyWord: String)
    case fetchFakeNews
    
    var scheme: String {
        switch self {
            default:
                return "https"
        }
    }
    
    var baseURL: String {
        switch self {
            case .fetchFakeNews:
                return "smaludiznski.github.io"
            default:
                return "newsapi.org"
        }
    }
    
    var path: String {
        switch self {
        case .fetchFakeNews:
            return "/newsapi/news.json"
            default:
                return "/v2/everything"
        }
    }
    
    var parameters: [URLQueryItem] {
        let apiKey = "a64ff86c6e3345e09731c020fc8a3449"
        
        switch self {
        case .fetchNews(keyWord: let keyWord):
                return [URLQueryItem(name: "q", value: keyWord),
                        URLQueryItem(name: "apiKey", value: apiKey),
                        URLQueryItem(name: "language", value: "en")]
        default:
            return []
        }
    }
    
    var method: String {
        switch self {
            default:
                return "GET"
        }
    }
    
    
}
