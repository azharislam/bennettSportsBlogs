//
//  APIService.swift
//  BennettsBlog
//
//  Created by Azhar Islam on 12/08/2023.
// accessKey = "rmgjArVNUsjyqSXc8PMY___b-PvtDgCswy-ZGuFvaRQ"
// secretKey = "tPAOWmdTSB7IOmSJm5VyTuthCzdaoErMWbr2VkjgXKM"

import Foundation

protocol APIServiceProtocol {
    func fetchPhotos(completion: @escaping (Result<[Photo], Error>) -> Void)
}

struct APIConfig {
    static let baseURL = "https://api.unsplash.com/photos/"
    static let clientID = "rmgjArVNUsjyqSXc8PMY___b-PvtDgCswy-ZGuFvaRQ"
}

class APIService: APIServiceProtocol {
    
    func fetchPhotos(completion: @escaping (Result<[Photo], Error>) -> Void) {
        guard let url = URL(string: "\(APIConfig.baseURL)?client_id=\(APIConfig.clientID)") else {
            completion(.failure(APIError.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(APIError.noData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let photos = try decoder.decode([Photo].self, from: data)
                completion(.success(photos))
            } catch {
                print("Decoding error: \(error)")
                completion(.failure(APIError.decodingError))
            }
        }
        
        task.resume()
    }
}

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
