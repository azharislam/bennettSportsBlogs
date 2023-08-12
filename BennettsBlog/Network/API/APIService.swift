//
//  APIService.swift
//  BennettsBlog
//
//  Created by Azhar Islam on 12/08/2023.
//

import Foundation

enum APIError: Error {
    case badRequest
    case unauthorized
    case forbidden
    case notFound
    case serverError
    case unknown
    case decodingError
}

class APIService {
    static let shared = APIService()

    private let baseURL = URL(string: "https://api.unsplash.com/")!
    private let accessKey = "rmgjArVNUsjyqSXc8PMY___b-PvtDgCswy-ZGuFvaRQ"
    private let secretKey = "tPAOWmdTSB7IOmSJm5VyTuthCzdaoErMWbr2VkjgXKM"
    
    private var headers: [String: String] {
        return [
            "Accept-Version": "v1",
            "Authorization": "Client-ID \(accessKey)"
        ]
    }

    func fetchBlogs(completion: @escaping (Result<[BlogsModel], APIError>) -> Void) {
        let endpoint = baseURL.appendingPathComponent("photos/")
        var urlComponents = URLComponents(url: endpoint, resolvingAgainstBaseURL: true)!
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: accessKey)
        ]

        var request = URLRequest(url: urlComponents.url!)
        request.allHTTPHeaderFields = headers

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case 200:
                    if let data = data {
                        do {
                            let blogs = try JSONDecoder().decode([BlogsModel].self, from: data)
                            DispatchQueue.main.async {
                                completion(.success(blogs))
                            }
                        } catch {
                            DispatchQueue.main.async {
                                completion(.failure(.decodingError))
                                print(error.localizedDescription)
                            }
                        }
                    }
                case 400:
                    DispatchQueue.main.async {
                        completion(.failure(.badRequest))
                    }
                case 401:
                    DispatchQueue.main.async {
                        completion(.failure(.unauthorized))
                    }
                case 403:
                    DispatchQueue.main.async {
                        completion(.failure(.forbidden))
                    }
                case 404:
                    DispatchQueue.main.async {
                        completion(.failure(.notFound))
                    }
                case 500...503:
                    DispatchQueue.main.async {
                        completion(.failure(.serverError))
                    }
                default:
                    DispatchQueue.main.async {
                        completion(.failure(.unknown))
                    }
                }
            }
        }
        task.resume()
    }
}
