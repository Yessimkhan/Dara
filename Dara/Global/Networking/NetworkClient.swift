//
//  Networking.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 07.04.2024.
//

import Foundation
import Alamofire

public final class NetworkClient {
    
    // MARK: - Properties
    public static let shared = NetworkClient()
    private let session: Session
    
    // Base URL for your Web Service
    private let baseURL = "http://localhost:5100"
    
    // MARK: - Initialization
    private init() {
        // Customize the session configuration as needed
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30 // Timeout interval in seconds
        // Add any additional configuration options here
        
        // Initialize the session with the configuration
        self.session = Session(configuration: configuration)
    }
    
    // MARK: - Methods
    
    /// Sends a GET request to the specified endpoint with headers and a Bearer token.
    /// - Parameters:
    ///   - endpoint: The endpoint path to request (e.g., "users/list").
    ///   - parameters: The parameters to be encoded with the request.
    ///   - token: The Bearer token to authenticate the request.
    ///   - additionalHeaders: Additional headers to include in the request.
    ///   - completion: The completion handler to call when the request is complete.
    public func get(endpoint: String, parameters: Parameters? = nil, token: String?, additionalHeaders: [String: String]? = nil, completion: @escaping (Result<Data, AFError>) -> Void) {
        var headers = HTTPHeaders()
        headers.add(.authorization(bearerToken: token ?? ""))
        if let additionalHeaders = additionalHeaders {
            for (header, value) in additionalHeaders {
                headers.add(name: header, value: value)
            }
        }
        request(endpoint, method: .get, headers: headers, completion: completion)
    }
    
    /// Sends a POST request to the specified endpoint.
    /// - Parameters:
    ///   - endpoint: The endpoint path to request.
    ///   - parameters: The parameters to be encoded with the request.
    ///   - completion: The completion handler to call when the request is complete.
    public func post(endpoint : String, parameters: Parameters? = nil, completion: @escaping (Result<Data, AFError>) -> Void) {
        request(endpoint, method: .post, parameters: parameters, completion: completion)
    }
    
    //    public func POST<T: Decodable, Q: Encodable>(
    //        path: String,
    //        params: Q,
    //        shouldAuthenticate: Bool = true
    //    ) async throws -> T {
    //        try await makeRequestWithBody(
    //            path: path,
    //            method: .post,
    //            params: params,
    //            interceptor: shouldAuthenticate ? authenticator : nil
    //        )
    //    }
    
    
    /// A private method to centralize the request logic with headers.
    /// - Parameters:
    ///   - endpoint: The endpoint path to request.
    ///   - method: The HTTP method to use.
    ///   - parameters: The parameters to be encoded with the request.
    ///   - headers: The HTTP headers to include in the request.
    ///   - completion: The completion handler to call when the request is complete.
    private func request(_ endpoint: String, method: HTTPMethod, parameters: Parameters? = nil, headers: HTTPHeaders? = nil, completion: @escaping (Result<Data, AFError>) -> Void) {
        let url = baseURL + endpoint
        
        print("Requesting: \(url) with parameters: \(String(describing: parameters))")
        
        session.request(url, method: method, parameters: parameters, headers: headers).responseData { response in
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
