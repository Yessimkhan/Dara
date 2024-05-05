//
//  Networking.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 07.04.2024.
//

// MARK: - Networking.swift
import Foundation
import Alamofire

public final class NetworkClient {
    
    // MARK: - Properties
    public static let shared = NetworkClient()
    private let session: Session
    
    // Base URL for your Web Service
    private let baseURL = "http://64.23.192.96"
    
    // MARK: - Initialization
    private init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30 // Timeout interval in seconds
        // Add any additional configuration options here
        
        self.session = Session(configuration: configuration)
    }
    
    // MARK: - Methods
    
    /// Sends a POST request to the specified endpoint.
    public func post(endpoint: String, parameters: Parameters? = nil, completion: @escaping (Result<Data, AFError>) -> Void) {
        request(endpoint, method: .post, parameters: parameters, completion: completion)
    }
    
    /// Sends a GET request to the specified endpoint.
    public func get(endpoint: String, parameters: Parameters? = nil, headers: HTTPHeaders? = nil, completion: @escaping (Result<Data, AFError>) -> Void) {
        request(endpoint, method: .get, parameters: parameters, headers: headers, completion: completion)
    }
    
    /// Sends a Download request to the specified endpoint.
    public func download(_ endpoint: String, headers: HTTPHeaders? = nil, completion: @escaping (Result<(data: Data, response: HTTPURLResponse), AFError>) -> Void) {
        let url = "\(baseURL)/\(endpoint)"

        session.download(url, headers: headers).responseData { response in
            switch response.result {
            case .success(let data):
                if let httpResponse = response.response {
                    completion(.success((data: data, response: httpResponse)))
                } else {
                    completion(.failure(AFError.responseValidationFailed(reason: .dataFileNil)))
                }
            case .failure(let error):
                print("Error: \(error)")
                completion(.failure(error))
            }
        }
    }

    /// A private method to centralize the request logic with headers.
    private func request(_ endpoint: String, method: HTTPMethod, parameters: Parameters? = nil, headers: HTTPHeaders? = nil, completion: @escaping (Result<Data, AFError>) -> Void) {
        var url = baseURL + endpoint
        session.request(url, method: method, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseData { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                print("Error: \(error)") // Debug: Log any errors
                completion(.failure(error))
            }
        }
    }
}
