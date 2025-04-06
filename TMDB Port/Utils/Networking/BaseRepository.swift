//
//  BaseRepository.swift
//  TMDB Port
//
//  Created by Mohamad Mohamad on 2025. 04. 06..
//


protocol BaseRepository {}

extension BaseRepository {
    func sendRequest<Response: Decodable>(
        call: () async throws -> Response,
        offlineCall: (() async throws -> Response)? = nil,
        cacheCall  : ((Response) async -> Void)? = nil
    ) async -> Result<Response, APIErrorModel> {
        do {
            let result = try await call()
            if let cacheCall {
                await cacheCall(result)
            }
            return .success(result)
        } catch(let error) {
            if error is APIErrorModel {
                return .failure(error as! APIErrorModel)
            } else {
                return .failure(APIErrorModel(message: error.localizedDescription))
            }
        }
    }
}
