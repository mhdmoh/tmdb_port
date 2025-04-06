//
//  GenreDSProtocol.swift
//  TMDB Port
//
//  Created by Mohamad Mohamad on 2025. 04. 06..
//

import Foundation

protocol GenreDSProtocol {
    func getMovieGenres() async throws -> GenreResponse
    func getTvGenres() async throws -> GenreResponse
}
