//
//  APIRequest.swift
//  TMDB Port
//
//  Created by Mohamad Mohamad on 06/04/2025.
//

import Foundation

enum HttpMethod:String {
    case get, post, put, patch, delete
}

enum ContentType: String {
    case json       = "application/json"
    case multipart  = "application/x-www-form-urlencoded"
}

protocol APIRequestProtocol {
    associatedtype Body: Encodable
    associatedtype Queries: APIQueriesProtocol
    associatedtype Headers: APIHeadersProtocol
    associatedtype Response: Codable
    
    var method: HttpMethod { get }
    var contentType: ContentType { get }
    
    func createURL() -> URL?
}

struct APIRequest<Body, Queries, Headers, Response>: APIRequestProtocol where Body: Encodable, Queries: APIQueriesProtocol, Headers: APIHeadersProtocol, Response: Codable {
    
    let path: String
    let method: HttpMethod
    let queries: Queries?
    let contentType: ContentType
    
    init(
        path: String,
        method: HttpMethod = .get,
        queries: Queries? = nil,
        contentType: ContentType = .json
    ) {
        self.path = path
        self.method = method
        self.queries = queries
        self.contentType = contentType
    }
    
    func createURL() -> URL? {
        var components = URLComponents(string: "\(MConstants.baseURL.rawValue)\(path)")
        components?.queryItems = queries?.getQueries()
        components?.queryItems?.append(URLQueryItem(name: "appid", value: EnvironmentVars.appid ))
        return components?.url
    }
}
