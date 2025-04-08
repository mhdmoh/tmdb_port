//
//  TrendingEndpoints.swift
//  TMDB Port
//
//  Created by Mohamad Mohamad on 2025. 04. 07..
//

import Foundation

struct TrendingEndpoints: APIEndpointProtocol {
    typealias Endpoint = Endpoints
    
    enum Endpoints: String {
        case movie = "trending/movie/day"
        case tv = "trending/tv/day"
        case person = "trending/person/day"
    }
    
    func trendingMovies() -> APIRequest<EmptyBody, EmptyQueries, AuthorizedHeaders, PaginationResponse<Media>> {
        return .init(path: Endpoints.movie.rawValue)
    }
    
    func trendingShows() -> APIRequest<EmptyBody, EmptyQueries, AuthorizedHeaders, PaginationResponse<Media>> {
        return .init(path: Endpoints.tv.rawValue)
    }
    
    func trendingPeople() -> APIRequest<EmptyBody, EmptyQueries, AuthorizedHeaders, PaginationResponse<Person>> {
        return .init(path: Endpoints.person.rawValue)
    }
}
