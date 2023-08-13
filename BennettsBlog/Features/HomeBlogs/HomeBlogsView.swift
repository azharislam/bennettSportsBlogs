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
        NavigationView {
            Group {
                if viewModel.isLoading {
                    ProgressView()
                } else if let error = viewModel.error {
                    Text(error.localizedDescription)
                } else {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(viewModel.photos, id: \.id) { photo in
                                NavigationLink(destination: BlogDetailView(photo: photo)) {
                                    BlogThumbnailView(photo: photo)
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Blogs")
            .onAppear {
                viewModel.fetchPhotos()
            }
        }
    }
}

struct BlogThumbnailView: View {
    let photo: Photo

    var body: some View {
        VStack {
            Image(uiImage: UIImage(data: try! Data(contentsOf: photo.urls.thumb)) ?? UIImage())
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 150, height: 150)
                .clipped()
            Text(photo.description ?? "No Description")
                .font(.caption)
                .lineLimit(1)
        }
    }
}

struct HomeBlogsView_Previews: PreviewProvider {
    static var previews: some View {
        HomeBlogsView()
    }
}

