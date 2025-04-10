//
//  APIClient.swift
//  TMDB Port
//
//  Created by Mohamad Mohamad on 06/04/2025.
//

import Foundation

protocol APIClientProtocol {
    func request<Request: APIRequestProtocol> (
        using request: Request,
        body: Request.Body?,
        headers: Request.Headers?
    ) async throws -> Request.Response
}

extension APIClientProtocol {
    func request<Request>(
        using request: Request
    ) async throws -> Request.Response where Request : APIRequestProtocol, Request.Body == EmptyBody, Request.Headers == EmptyHeaders {
        return try await self.request(using: request, body: nil , headers: nil)
    }
    
    func request<Request>(
        using request: Request,
        with headers: Request.Headers? = nil
    ) async throws -> Request.Response where Request : APIRequestProtocol, Request.Body == EmptyBody, Request.Headers == AuthorizedHeaders {
        return try await self.request(using: request, body: nil , headers: headers ?? .init())
    }
}


struct APIClient: APIClientProtocol {
    let decoder = JSONDecoder()
    let encoder = JSONEncoder()
    
    init() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    private func setContentType(for request: inout URLRequest, contentType: ContentType) {
        request.setValue(contentType.rawValue, forHTTPHeaderField: "Content-Type")
    }
    
    private func setToken(for request: inout URLRequest, token: String) {
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    }
    
    func request<Request>(
        using request: Request,
        body: Request.Body? = nil,
        headers: Request.Headers? = nil
    ) async throws -> Request.Response where Request : APIRequestProtocol {
        guard let url = request.createURL() else {
            throw APIErrorModel(message: APIError.invalidURL.localizedDescription)
        }
        
        var urlRequest = URLRequest(url: url)
        
        if let headers = headers {
            urlRequest.allHTTPHeaderFields = headers.getHeaders()
            if headers.isAuth {
                let token = EnvironmentVars.appid
                setToken(for: &urlRequest, token: token)
            }
        }
        urlRequest.httpMethod = request.method.rawValue
        MLogger.shared.log("Response Status Code: \(String(describing: urlRequest.url))", level: .info)

        let session = URLSession.shared
        do{
            if Request.Body.self != EmptyBody.self {
                switch request.contentType {
                case .json:
                    urlRequest.httpBody = try encoder.encode(body)
                    setContentType(for: &urlRequest, contentType: request.contentType)
                    MLogger().log(String(data: urlRequest.httpBody!, encoding: .utf8) ?? "NO Body")
                case .multipart:
                    throw APIErrorModel(message: APIError.invalidContentType.localizedDescription)
                }
            }
            
            let (data, response) = try await session.data(for: urlRequest)
            if let httpResponse = response as? HTTPURLResponse {
                MLogger.shared.log("Response Status Code: \(httpResponse.statusCode)", level: .info)
            }
            guard (200...299).contains((response as? HTTPURLResponse)?.statusCode ?? -1) else {
                let errorResponse = String(data: data, encoding: .utf8) ?? "Unknown error response"
                MLogger.shared.log("Server Error: \(errorResponse)", level: .error)
                
                var result: APIErrorModel? = nil
                do{
                    result = try await Task.detached {
                        try decoder.decode(APIErrorModel.self, from: data)
                    }.value
                }catch{
                    MLogger.shared.log("Couldn't decode error response", level: .error)
                }
                throw result ?? APIErrorModel.init()
            }
//            MLogger().log(String(data: data, encoding: .utf8) ?? "", level: .debug)
            let result = try await Task.detached {
                try decoder.decode(Request.Response.self, from: data)
            }.value
            
            return result
        }catch {
            print(error)
            throw APIErrorModel(message: error.localizedDescription)
        }
    }
}
