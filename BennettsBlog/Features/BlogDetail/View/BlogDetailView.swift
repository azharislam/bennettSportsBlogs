//
//  BlogDetailView.swift
//  BennettsBlog
//
//  Created by Azhar Islam on 12/08/2023.
//

import SwiftUI

struct BlogDetailView: View {
    let photo: Photo

    var body: some View {
        VStack {
            Image(uiImage: UIImage(data: try! Data(contentsOf: photo.urls.full)) ?? UIImage())
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: .infinity)
            Text(photo.description ?? "No Description")
                .padding()
        }
        .navigationTitle("Blog Detail")
    }
}

//struct BlogDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        BlogDetailView()
//    }
//}
