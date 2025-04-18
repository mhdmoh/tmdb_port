//
//  GenreServiceProtocol.swift
//  TMDB Port
//
//  Created by Mohamad Mohamad on 2025. 04. 06..
//

import Foundation

protocol GenreServiceProtocol {
    func getMovieGenres() async -> Result<GenreResponse, APIErrorModel>
    func getTvGenres() async -> Result<GenreResponse, APIErrorModel>
}
