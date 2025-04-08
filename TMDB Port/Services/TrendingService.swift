//
//  TrendingService.swift
//  TMDB Port
//
//  Created by Mohamad Mohamad on 2025. 04. 07..
//

import Foundation

struct TrendingService: TrendingServiceProtocol {
    private let repo: TrendingRepoProtocol
    init(repo: TrendingRepoProtocol) {
        self.repo = repo
    }
    
    func getTrendingMovies() async -> Result<PaginationResponse<Media>, APIErrorModel> {
        return await repo.getTrendingMovies()
    }
    
    func getTrendingTvShows() async -> Result<PaginationResponse<Media>, APIErrorModel> {
        return await repo.getTrendingTvShows()
    }
    
    func getTrendingPeople() async -> Result<PaginationResponse<Person>, APIErrorModel> {
        return await repo.getTrendingPeople()
    }
}
