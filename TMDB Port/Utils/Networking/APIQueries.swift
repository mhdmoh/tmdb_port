//
//  APIQueries.swift
//  TMDB Port
//
//  Created by Mohamad Mohamad on 06/04/2025.
//

import Foundation

protocol APIQueriesProtocol {
    func getQueries() -> [URLQueryItem]
}

struct EmptyQueries: APIQueriesProtocol {
    func getQueries() -> [URLQueryItem] {
        []
    }
}
