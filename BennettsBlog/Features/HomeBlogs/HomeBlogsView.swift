//
//  ContentView.swift
//  BennettsBlog
//
//  Created by Azhar Islam on 12/08/2023.
//

import SwiftUI

struct HomeBlogsView: View {
    @StateObject private var viewModel = HomeBlogsViewModel()

    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView()
            } else if let error = viewModel.apiError {
                Text("Error: \(error.localizedDescription)")
            } else {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 16) {
                        ForEach(viewModel.blogs, id: \.id) { blog in
                            BlogCardView(blog: blog)
                                .onTapGesture {
                                    print("GO TO DETAIL VIEW")
                                }
                        }
                    }
                }
                .padding()
            }
        }
    }
}

struct BlogCardView: View {
    var blog: BlogsModel

    var body: some View {
        VStack {
            if let url = URL(string: blog.urls.regular) {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 150, height: 200)
                .cornerRadius(10)
                .shadow(radius: 5)
            }
        }
    }
}

struct HomeBlogsView_Previews: PreviewProvider {
    static var previews: some View {
        HomeBlogsView()
    }
}

