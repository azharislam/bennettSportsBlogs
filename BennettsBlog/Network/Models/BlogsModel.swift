//
//  BlogsListModel.swift
//  BennettsBlog
//
//  Created by Azhar Islam on 12/08/2023.
//

import Foundation

struct BlogsModel: Decodable {
    let id: String
    let slug: String
    let createdAt: Date
    let updatedAt: Date
    let promotedAt: Date?
    let width: Int
    let height: Int
    let color: String
    let blurHash: String
    let description: String?
    let altDescription: String?
    let urls: Urls
    let links: Links
    let likes: Int
    let likedByUser: Bool
    let currentUserCollections: [String]
    let sponsorship: Sponsorship?
    let user: User

    enum CodingKeys: String, CodingKey {
        case id, slug, width, height, color, urls, links, likes, user
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case promotedAt = "promoted_at"
        case blurHash = "blur_hash"
        case description
        case altDescription = "alt_description"
        case likedByUser = "liked_by_user"
        case currentUserCollections = "current_user_collections"
        case sponsorship
    }
}

struct Urls: Decodable {
    let raw: String
    let full: String
    let regular: String
    let small: String
    let thumb: String
    let smallS3: String?

    enum CodingKeys: String, CodingKey {
        case raw, full, regular, small, thumb
        case smallS3 = "small_s3"
    }
}

struct Links: Decodable {
    let `self`: String
    let html: String
    let download: String
    let downloadLocation: String

    enum CodingKeys: String, CodingKey {
        case `self`, html, download
        case downloadLocation = "download_location"
    }
}

struct Sponsorship: Decodable {
    let impressionUrls: [String]
    let tagline: String
    let taglineUrl: String
    let sponsor: User

    enum CodingKeys: String, CodingKey {
        case impressionUrls = "impression_urls"
        case tagline
        case taglineUrl = "tagline_url"
        case sponsor
    }
}

struct User: Decodable {
    let id: String
    let updatedAt: Date
    let username: String
    let name: String
    let firstName: String
    let lastName: String?
    let twitterUsername: String?
    let portfolioUrl: String?
    let bio: String?
    let location: String?
    let links: Links
    let profileImage: ProfileImage
    let instagramUsername: String?
    let totalCollections: Int
    let totalLikes: Int
    let totalPhotos: Int
    let acceptedTos: Bool
    let forHire: Bool

    enum CodingKeys: String, CodingKey {
        case id, username, name, links
        case updatedAt = "updated_at"
        case firstName = "first_name"
        case lastName = "last_name"
        case twitterUsername = "twitter_username"
        case portfolioUrl = "portfolio_url"
        case bio, location
        case profileImage = "profile_image"
        case instagramUsername = "instagram_username"
        case totalCollections = "total_collections"
        case totalLikes = "total_likes"
        case totalPhotos = "total_photos"
        case acceptedTos = "accepted_tos"
        case forHire = "for_hire"
    }
}

struct ProfileImage: Decodable {
    let small: String
    let medium: String
    let large: String
}
