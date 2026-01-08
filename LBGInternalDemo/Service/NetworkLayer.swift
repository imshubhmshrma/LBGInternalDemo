//
//  NetworkLayer.swift
//  LBGInternalDemo
//
//  Created by Shubham Sharma on 26/12/25.
//

import Foundation

class NetworkLayer {
    
    static let shared = NetworkLayer()
    private init() { }
    let session = URLSession.shared
     
    
    func makeGetRequest(urlString: String,
                        completion: @escaping (Result<Data,APIError>) -> Void)  {
        
        guard let urll = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }
        
        session.dataTask(with: urll) { (data, response, error)  in
            guard let data else {
                completion(.failure(.invalidData))
                return
            }
            guard let response = response as? HTTPURLResponse, 200 ... 299  ~= response.statusCode else {
                completion(.failure(.invalidResponse))
                return
            }
            completion(.success(data))
        }.resume()
    }
     
    func makeGetRequest(urlString: String) async -> Result<Data,APIError> {
        guard let apiURL = URL(string: urlString) else { return (.failure(.invalidURL))}
        do{
            let (data, _) = try await session.data(from: apiURL)
            return .success(data)
        } catch {
            return .failure(.invalidURL)
        }
    }
}
