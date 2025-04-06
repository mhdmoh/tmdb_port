//
//  GenreEndpoints.swift
//  TMDB Port
//
//  Created by Mohamad Mohamad on 2025. 04. 06..
//

import Foundation

struct GenreEndpoints: APIEndpointProtocol {
    typealias Endpoint = Endpoints
    
    enum Endpoints: String {
        case movieGenres    = "genre/movie/list"
        case tvGenres       = "genre/tv/list"
    }
    
    func movieGenres() -> APIRequest<
        EmptyBody,
        EmptyQueries,
        AuthorizedHeaders,
        GenreResponse
    > {
        return .init(path: Endpoints.movieGenres.rawValue)
    }
    
    func tvGenres() -> APIRequest<
        EmptyBody,
        EmptyQueries,
        AuthorizedHeaders,
        GenreResponse
    > {
        return .init(path: Endpoints.tvGenres.rawValue)
    }
}
