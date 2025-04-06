//
//  GenreRepo.swift
//  TMDB Port
//
//  Created by Mohamad Mohamad on 2025. 04. 06..
//

import Foundation

struct GenreRepo: GenreRepoProtocol, BaseRepository{
    private let remoteDS: GenreDSProtocol
    init(remoteDS: GenreDSProtocol) {
        self.remoteDS = remoteDS
    }
    
    func getTvGenres() async -> Result<GenreResponse, APIErrorModel> {
        return await sendRequest {
            try await remoteDS.getMovieGenres()
        }
    }
    
    func getMovieGenres() async -> Result<GenreResponse, APIErrorModel> {
        return await sendRequest {
            try await remoteDS.getTvGenres()
        }
    }
}
