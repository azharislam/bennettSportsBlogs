//
//  ContentView.swift
//  BennettsBlog
//
//  Created by Azhar Islam on 12/08/2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct HomeBlogsView: View {
    @StateObject private var viewModel = HomeBlogsViewModel()

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    loadingOrErrorView
                    headlineBlogView
                    categoriesView
                }
                .padding(.bottom)
            }
            .navigationTitle("Latest Blog")
            .padding(.top, 10)
            .onAppear {
                viewModel.fetchPhotos()
            }
        }
    }

    @ViewBuilder
    private var loadingOrErrorView: some View {
        if viewModel.isLoading {
            ProgressView()
        } else if let error = viewModel.error {
            Text(error.localizedDescription)
        }
    }

    @ViewBuilder
    private var headlineBlogView: some View {
        if let headlineBlog = viewModel.headlineBlog {
            NavigationLink(destination: BlogDetailView(blogPost: headlineBlog)) {
                VStack(alignment: .leading) {
                    WebImage(url: headlineBlog.urls.full)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 250)
                        .clipped()
                        .padding([.leading, .trailing, .top])
                    
                    Text((headlineBlog.altDescription ?? headlineBlog.description ?? "A blog post for users to tap on.")
                        .capitalizingFirstLetter())
                        .font(.headline)
                        .foregroundColor(.black)
                        .padding([.leading, .trailing, .bottom])
                }
            }
            .foregroundColor(.black)
        }
    }

    private var categoriesView: some View {
        ForEach(Array(viewModel.blogCategories.enumerated()), id: \.offset) { index, blogs in
            Text("Category \(index + 1)")
                .font(.title2)
                .bold()
                .padding(.leading)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(blogs, id: \.id) { blog in
                        NavigationLink(destination: BlogDetailView(blogPost: blog)) {
                            BlogThumbnailView(blogPost: blog)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

struct HomeBlogsView_Previews: PreviewProvider {
    static var previews: some View {
        HomeBlogsView()
    }
}

