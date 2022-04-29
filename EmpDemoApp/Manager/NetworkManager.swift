//
//  NetworkManager.swift
//  EmpDemoApp
//
//  Created by Nitesh on 29/04/22.
//

import Foundation

public enum Result<Success, Failure: Error > {
    case success(Success)
    case failure(Failure)
}

enum APIError: Error {
    case data
    case decodingJSON
    case error
    case statusCode
    var message: String {
        switch self {
        default:
            return "Sorry, Something went wrong"
        }
    }
}

class NetworkManager {
    static let shared =  NetworkManager()
    private let sucessRange = 200..<300

    private init(){ }

    func getfetchData<T: Decodable>(url: URL, completion: @escaping (Result<T, APIError>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data else {
                return completion(.failure(.data))
            }
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
                return completion(.failure(.statusCode))
            }
            
            guard self.sucessRange.contains(statusCode) else {
                return completion(.failure(.error))
            }
            if let model = try? JSONDecoder().decode(T.self, from: data) {
                completion(.success(model))
            } else {
                completion(.failure(.decodingJSON))
            }
        }
        dataTask.resume()
    }

}
struct Root<T: Codable>: Codable {
    
    let data: T?

    enum CodingKeys: String, CodingKey {
        case data = "data1"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.data = try container.decodeIfPresent(T.self, forKey: CodingKeys.data)
    }

}
