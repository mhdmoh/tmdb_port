//
//  GenreRepoProtocol.swift
//  TMDB Port
//
//  Created by Mohamad Mohamad on 2025. 04. 06..
//

import Foundation
protocol GenreRepoProtocol {
    func getMovieGenres() async -> Result<GenreResponse, APIErrorModel>
    func getTvGenres() async -> Result<GenreResponse, APIErrorModel>
}
