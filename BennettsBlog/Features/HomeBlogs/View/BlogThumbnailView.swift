//
//  BlogThumbnailView.swift
//  BennettsBlog
//
//  Created by Azhar Islam on 13/08/2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct BlogThumbnailView: View {
    let blogPost: Blog

    var body: some View {
        VStack(alignment: .leading) {
            WebImage(url: blogPost.urls.thumb)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 150, height: 150)
                .clipped()
            Text((blogPost.altDescription ?? blogPost.description ?? "This is a blog post for users to tap on.")
                .capitalizingFirstLetter())
                .font(.body)
                .foregroundColor(.black)
                .frame(maxWidth: 150, alignment: .leading)
                .padding(.top, 5)
        }
    }
}
