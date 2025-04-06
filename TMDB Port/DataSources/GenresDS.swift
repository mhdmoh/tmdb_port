//
//  GenresDS.swift
//  TMDB Port
//
//  Created by Mohamad Mohamad on 2025. 04. 06..
//

import Foundation

struct GenresDS: GenreDSProtocol {
    private let client: APIClientProtocol
    private let endpoints: GenreEndpoints
    
    init(client: APIClientProtocol, endpoints: GenreEndpoints) {
        self.client = client
        self.endpoints = endpoints
    }
    
    func getMovieGenres() async throws -> GenreResponse {
        return try await client.request(using: endpoints.movieGenres())
    }
    
    func getTvGenres() async throws -> GenreResponse {
        return try await client.request(using: endpoints.tvGenres())
    }
    
}
