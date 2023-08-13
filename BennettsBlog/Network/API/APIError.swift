//
//  APIError.swift
//  BennettsBlog
//
//  Created by Azhar Islam on 13/08/2023.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case noData
    case decodingError
}

extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL is invalid."
        case .noData:
            return "No data was received from the server."
        case .decodingError:
            return "There was an error decoding the data."
        }
    }
}
