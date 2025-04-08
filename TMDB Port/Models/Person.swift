//
//  Person.swift
//  TMDB Port
//
//  Created by Mohamad Mohamad on 2025. 04. 07..
//


struct Person: Codable {
    let id: Int
    let name: String
    let originalName, mediaType: String?
    let adult: Bool
    let popularity: Double
    let gender: Int
    let knownForDepartment, profilePath: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case originalName = "original_name"
        case mediaType = "media_type"
        case adult, popularity, gender
        case knownForDepartment = "known_for_department"
        case profilePath = "profile_path"
    }
}
