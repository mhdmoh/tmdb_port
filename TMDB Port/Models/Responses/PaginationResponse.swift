//
//  PaginationResponse.swift
//  TMDB Port
//
//  Created by Mohamad Mohamad on 2025. 04. 07..
//

import Foundation
struct PaginationResponse<T: Codable> : Codable {
    var page: Int
    var results: [T]
}
