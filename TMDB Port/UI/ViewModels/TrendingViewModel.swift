//
//  TrendingViewModel.swift
//  TMDB Port
//
//  Created by Mohamad Mohamad on 2025. 04. 07..
//

import Foundation

class TrendingViewModel: ObservableObject {
    private let service: TrendingServiceProtocol
    @Published var media: [Media] = []
    @Published var people: [Person] = []
    @Published var error: APIErrorModel?
    @Published var isLoading: Bool = false
    
    enum TrendingType: String, CaseIterable,  RawRepresentable {
        case movies = "Movies"
        case shows  = "TvShows"
        case people = "People"
    }
    
    init(service: TrendingServiceProtocol) {
        self.service = service
    }
    
    private func handleResult<T>(_ result: Result<PaginationResponse<T>, APIErrorModel>, assignTo keyPath: ReferenceWritableKeyPath<TrendingViewModel, [T]>) {
        switch result {
        case .success(let response):
            self[keyPath: keyPath] = response.results
            self.error = nil
        case .failure(let error):
            self.error = error
        }
    }

    func getTrending(of type: TrendingType) async {
        isLoading = true
        defer { isLoading = false }

        switch type {
        case .movies:
            let result = await service.getTrendingMovies()
            handleResult(result, assignTo: \.media)

        case .shows:
            let result = await service.getTrendingTvShows()
            handleResult(result, assignTo: \.media)

        case .people:
            let result = await service.getTrendingPeople()
            handleResult(result, assignTo: \.people)
        }
    }
    
}
