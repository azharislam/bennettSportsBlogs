//
//  HomeBlogsViewModel.swift
//  BennettsBlog
//
//  Created by Azhar Islam on 12/08/2023.
//

import Foundation
import SwiftUI
import Combine

class HomeBlogsViewModel: ObservableObject {

    private var apiService: APIServiceProtocol
    private var cancellables = Set<AnyCancellable>()

    @Published var photos: [Photo] = []
    @Published var isLoading: Bool = false
    @Published var error: APIError?

    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }

    func fetchPhotos() {
        self.isLoading = true
        apiService.fetchPhotos { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let photos):
                    self?.photos = photos
                case .failure(let error):
                    self?.error = error as? APIError
                }
                self?.isLoading = false
            }
        }
    }
}
