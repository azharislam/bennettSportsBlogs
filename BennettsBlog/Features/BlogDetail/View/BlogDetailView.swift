//
//  BlogDetailView.swift
//  BennettsBlog
//
//  Created by Azhar Islam on 12/08/2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct BlogDetailView: View {
    let blogPost: Blog

    var body: some View {
        VStack {
            WebImage(url: blogPost.urls.full)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: .infinity)
            Text((blogPost.description ?? blogPost.altDescription ?? "")
                .capitalizingFirstLetter())
                .padding()
        }
        .navigationTitle("Blog Detail")
    }
}
