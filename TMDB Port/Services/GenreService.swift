//
//  GenreService.swift
//  TMDB Port
//
//  Created by Mohamad Mohamad on 2025. 04. 06..
//

import Foundation

struct GenreService: GenreServiceProtocol {
    private let repo: GenreRepoProtocol
    init(repo: GenreRepoProtocol) {
        self.repo = repo
    }
    
    func getMovieGenres() async -> Result<GenreResponse, APIErrorModel> {
        return await repo.getMovieGenres()
    }
    
    func getTvGenres() async -> Result<GenreResponse, APIErrorModel> {
        return await repo.getTvGenres()
    }
}
