//
//  APIError.swift
//  TMDB Port
//
//  Created by Mohamad Mohamad on 06/04/2025.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case invalidResponse(error: Error)
    case invalidContentType
}
