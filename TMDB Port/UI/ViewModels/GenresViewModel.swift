//
//  GenresViewModel.swift
//  TMDB Port
//
//  Created by Mohamad Mohamad on 2025. 04. 06..
//

import Foundation

class GenresViewModel: ObservableObject {
    private let service: GenreServiceProtocol
    
    @Published var genres: [Genre] = []
    @Published var loading = false
    @Published var error: Error?
    
    init(service: GenreServiceProtocol) {
        self.service = service
    }
    
    func getGenres() async {
        loading = true
        error = nil
        let result = await service.getMovieGenres()
        switch result {
        case .success(let response):
            self.genres = response.genres
        case .failure(let error):
            self.error = error
        }
        loading = false
    }
    
}
