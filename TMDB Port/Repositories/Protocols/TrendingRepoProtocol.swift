//
//  TrendingRepoProtocol.swift
//  TMDB Port
//
//  Created by Mohamad Mohamad on 2025. 04. 07..
//

import Foundation

protocol TrendingRepoProtocol {
    func getTrendingMovies() async -> Result<PaginationResponse<Media>, APIErrorModel>
    func getTrendingTvShows() async -> Result<PaginationResponse<Media>, APIErrorModel>
    func getTrendingPeople() async -> Result<PaginationResponse<Person>, APIErrorModel>
}
