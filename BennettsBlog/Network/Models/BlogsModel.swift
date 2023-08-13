import Foundation

struct Blog: Codable {
    let id: String
    let createdAt: Date
    let updatedAt: Date
    let width: Int
    let height: Int
    let color: String?
    let description: String?
    let altDescription: String?
    let urls: URLS
    let user: User

    enum CodingKeys: String, CodingKey {
        case id, width, height, color, description, urls, user
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case altDescription = "alt_description"
    }
}

struct URLS: Codable {
    let raw: URL
    let full: URL
    let regular: URL
    let small: URL
    let thumb: URL
}

struct User: Codable {
    let id: String
    let username: String
    let profileImage: ProfileImage
    
    enum CodingKeys: String, CodingKey {
        case id, username
        case profileImage = "profile_image"
    }
}

struct ProfileImage: Codable {
    let small, medium, large: String
}

