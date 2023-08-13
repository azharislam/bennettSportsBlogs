//
//  BlogDetailView.swift
//  BennettsBlog
//
//  Created by Azhar Islam on 12/08/2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct BlogDetailView: View {
    @ObservedObject var viewModel: BlogDetailViewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                blogImage
                userInfo
                descriptionText
            }
            .padding()
        }
        .navigationTitle(Constants.BlogDetail.navigationTitle)
    }

    @ViewBuilder
    private var blogImage: some View {
        WebImage(url: viewModel.blogPost.urls.full)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(maxWidth: .infinity, maxHeight: 400)
            .clipped()
    }

    @ViewBuilder
    private var userInfo: some View {
        HStack {
            userProfile
            Spacer()
            postDate
        }
        .padding([.top, .bottom])
    }

    @ViewBuilder
    private var userProfile: some View {
        WebImage(url: viewModel.userProfileImageURL)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 50, height: 50)
            .clipShape(Circle())
        Text("@\(viewModel.blogPost.user.username)")
            .foregroundColor(.gray)
    }

    @ViewBuilder
    private var postDate: some View {
        Text(viewModel.formattedDate)
            .foregroundColor(.gray)
    }

    @ViewBuilder
    private var descriptionText: some View {
        Text(viewModel.displayDescription)
            .padding(.top)
    }
}
