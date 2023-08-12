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
    // Published properties that the view can bind to
    @Published var blogs: [BlogsModel] = []
    @Published var isLoading: Bool = false
    @Published var apiError: APIError?

    private var cancellables: Set<AnyCancellable> = []

    init() {
        fetchBlogs()
    }

    func fetchBlogs() {
        self.isLoading = true
        APIService.shared.fetchBlogs { [weak self] result in
            switch result {
            case .success(let blogs):
                self?.blogs = blogs
            case .failure(let error):
                self?.apiError = error
            }
            self?.isLoading = false
        }
    }
}
