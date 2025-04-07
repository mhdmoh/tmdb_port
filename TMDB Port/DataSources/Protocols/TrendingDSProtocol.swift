//
//  TrendingDSProtocol.swift
//  TMDB Port
//
//  Created by Mohamad Mohamad on 2025. 04. 07..
//

import Foundation

protocol TrendingDSProtocol {
    func getTrendingMovies() async throws -> PaginationResponse<Media>
    func getTrendingTvShows() async throws -> PaginationResponse<Media>
    func getTrendingPeople() async throws -> PaginationResponse<Person>
}
