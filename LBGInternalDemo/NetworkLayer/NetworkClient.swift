//
//  NetworkClient.swift
//  LBGInternalDemo
//
//  Created by Shubham Sharma on 26/12/25.
//

import Foundation

class NetworkClient: NetworkClientProtocol{
    
    private let session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    @MainActor
    func makeGetReques<T: Codable>(url: URL, completion: @escaping (Result<T, APIError>) -> Void)  {
        self.session.dataTask(with: url) { (data, response, error) in
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                completion(.failure(APIError.invalidResponse))
                return
            }
            guard let data = data else {
                completion(.failure(APIError.invalidData))
                return
            }
            do{
                let decodeResp = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodeResp))
            } catch {
                completion(.failure(APIError.decodingError))
            }
        }.resume()
    }
    
    
    func makeGetRequest<T:Codable>(url: URL) async -> (Result<T, APIError>){
        do{
            let (data, response) = try await session.data(from: url)
            if let validData = data as Data?{
                return (.success(validData as! T))
            } else {
                return (.failure(.invalidData))
            }
        } catch {
            return (.failure(.decodingError))
        } 
    }
    
}
