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
            .navigationTitle(Constants.HomeBlogs.navigationTitle)
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
            NavigationLink(destination: BlogDetailView(viewModel: BlogDetailViewModel(blogPost: headlineBlog))) {
                VStack(alignment: .leading) {
                    WebImage(url: headlineBlog.urls.full)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 250)
                        .clipped()
                        .padding([.leading, .trailing, .top])
                    
                    Text((headlineBlog.altDescription ?? headlineBlog.description ?? Constants.HomeBlogs.defaultBlogDescription)
                        .capitalizingFirstLetter())
                    .font(.custom("Arial", size: 20))
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.black)
                    .padding([.leading, .trailing, .bottom])
                }
                .padding(.bottom)
            }
            .foregroundColor(.black)
        }
    }
    
    private var categoriesView: some View {
        ForEach(Array(viewModel.blogCategories.enumerated()), id: \.offset) { index, blogs in
            Text("\(Constants.HomeBlogs.categoryTitle) \(index + 1)")
                .font(.title2)
                .bold()
                .padding(.leading)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(blogs, id: \.id) { blog in
                        NavigationLink(destination: BlogDetailView(viewModel: BlogDetailViewModel(blogPost: blog))) {
                            BlogThumbnailView(blogPost: blog)
                                .frame(width: 150)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
        .padding(.bottom)
    }
}

struct HomeBlogsView_Previews: PreviewProvider {
    static var previews: some View {
        HomeBlogsView()
    }
}
