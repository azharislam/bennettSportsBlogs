import Foundation

struct Photo: Codable {
    let id: String
    let createdAt: Date
    let updatedAt: Date
    let width: Int
    let height: Int
    let color: String?
    let description: String?
    let urls: URLS
    
    enum CodingKeys: String, CodingKey {
           case id, width, height, color, description, urls
           case createdAt = "created_at"
           case updatedAt = "updated_at"
    }
}

struct URLS: Codable {
    let raw: URL
    let full: URL
    let regular: URL
    let small: URL
    let thumb: URL
}
