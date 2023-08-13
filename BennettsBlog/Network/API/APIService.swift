//
//  APIService.swift
//  BennettsBlog
//
//  Created by Azhar Islam on 12/08/2023.
//

import Foundation

protocol APIServiceProtocol {
    func fetchPhotos(completion: @escaping (Result<[Blog], Error>) -> Void)
}

class APIService: APIServiceProtocol {
    
    func fetchPhotos(completion: @escaping (Result<[Blog], Error>) -> Void) {
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
                let photos = try decoder.decode([Blog].self, from: data)
                completion(.success(photos))
            } catch {
                print("Decoding error: \(error)")
                completion(.failure(APIError.decodingError))
            }
        }
        
        task.resume()
    }
}
