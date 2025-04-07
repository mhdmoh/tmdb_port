//
//  TrendingDS.swift
//  TMDB Port
//
//  Created by Mohamad Mohamad on 2025. 04. 07..
//

import Foundation
struct TrendingDS: TrendingDSProtocol {
    private let client: APIClientProtocol
    private let endpoint: TrendingEndpoints
    
    init(client: APIClientProtocol, endpoint: TrendingEndpoints) {
        self.client = client
        self.endpoint = endpoint
    }
    
    func getTrendingMovies() async throws -> PaginationResponse<Media> {
        return try await client.request(using: endpoint.trendingMovies())
    }
    
    func getTrendingTvShows() async throws -> PaginationResponse<Media> {
        return try await client.request(using: endpoint.trendingShows())
    }
    
    func getTrendingPeople() async throws -> PaginationResponse<Person> {
        return try await client.request(using: endpoint.trendingPeople())
    }
}
