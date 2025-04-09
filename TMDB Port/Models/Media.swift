//
//  Media.swift
//  TMDB Port
//
//  Created by Mohamad Mohamad on 2025. 04. 07..
//


struct Media: Codable {
    let backdropPath: String
    let id: Int
    let overview: String
    let originalTitle, title, name: String?
    let posterPath: String?
    let mediaType: String
    let adult: Bool
    let originalLanguage: String
    let genreIds: [Int]
    let popularity: Double
    let releaseDate, firstAirDate: String?
    let video: Bool?
    let voteAverage: Double
    let voteCount: Int
}
