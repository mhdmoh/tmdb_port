//
//  TrendingRepo.swift
//  TMDB Port
//
//  Created by Mohamad Mohamad on 2025. 04. 07..
//

import Foundation

struct TrendingRepo: TrendingRepoProtocol, BaseRepository {
    private let remoteDS: TrendingDSProtocol
    init(remoteDS: TrendingDSProtocol) {
        self.remoteDS = remoteDS
    }
    
    func getTrendingMovies() async -> Result<PaginationResponse<Media>, APIErrorModel> {
        return await sendRequest {
            return try await remoteDS.getTrendingMovies()
        }
    }
    
    func getTrendingTvShows() async -> Result<PaginationResponse<Media>, APIErrorModel> {
        return await sendRequest {
            return try await remoteDS.getTrendingMovies()
        }
    }
    
    func getTrendingPeople() async -> Result<PaginationResponse<Person>, APIErrorModel> {
        return await sendRequest {
            return try await remoteDS.getTrendingPeople()
        }
    }
}
