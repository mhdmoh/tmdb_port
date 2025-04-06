//
//  APIEndpoint.swift
//  TMDB Port
//
//  Created by Mohamad Mohamad on 06/04/2025.
//

import Foundation

protocol APIEndpointProtocol {
    associatedtype Endpoint: RawRepresentable where Endpoint.RawValue == String
}
