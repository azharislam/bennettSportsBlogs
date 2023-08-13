//
//  BlogDetailViewModel.swift
//  BennettsBlog
//
//  Created by Azhar Islam on 13/08/2023.
//

import Foundation

class BlogDetailViewModel: ObservableObject {
    let blogPost: Blog

    init(blogPost: Blog) {
        self.blogPost = blogPost
    }

    var userProfileImageURL: URL? {
        URL(string: blogPost.user.profileImage.small)
    }

    var formattedDate: String {
        dateFormatter.string(from: blogPost.createdAt)
    }

    var displayDescription: String {
        (blogPost.description ?? blogPost.altDescription ?? "").capitalizingFirstLetter()
    }

    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
}
