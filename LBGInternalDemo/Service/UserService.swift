//
//  UserService.swift
//  LBGInternalDemo
//
//  Created by Shubham Sharma on 26/12/25.
//

/*
 🧠 Rule of Thumb (Remember this)

 ❌ async throws -> Result<T, Error>
 ✅ async throws -> T OR async -> Result<T, Error>
 
 */

import Foundation
import Combine
//add more separation of concern
class UserService: UserServiceProtocol {
    let urlStr = "https://dummyjson.com/users"
    let session = URLSession.shared
    var cancellable = Set<AnyCancellable>()
    
    func getUsers(completion: @escaping (Result<[User], APIError>) -> Void) {
        guard let url = URL(string: urlStr) else { return }
        
        session.dataTaskPublisher(for: url)
            .tryMap { (data, response) in
                guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                    completion(.failure(.invalidResponse))
                    return Data()}
                return data
            }
            .decode(type: UsersResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { _ in } receiveValue: { response in
                completion(.success(response.users))
            }
            .store(in: &cancellable)
    } 
    
    
@MainActor    func getUsersWithoutPublisher(completion: @escaping(Result<[User],APIError>) -> Void) {
        
        guard let urll = URL(string: urlStr) else {
            completion(.failure(.invalidURL))
            return }
        guard let req = URLRequest(url: urll) as URLRequest? else {
            completion(.failure(.invalidURL))
            return }
        
        
        session.dataTask(with: req){ (data, response, error) in
            guard let data = data, error == nil else {
                completion(.failure(.invalidResponse))
                return
            }
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                completion(.failure(.invalidResponse))
                return
            }
            
            let decodedData = try? JSONDecoder().decode(UsersResponse.self, from: data)
            completion(.success(decodedData!.users))
        }.resume()
    }
    
    
    func getUsersFromNetworkLayer(completion: @escaping(Result<[User],APIError>)->Void) {
        NetworkLayer.shared.makeGetRequest(urlString: urlStr) { result in
            switch result {
            case .success(let data):
                do {
                    let decodedResponse = try JSONDecoder().decode(UsersResponse.self, from: data)
                    completion(.success(decodedResponse.users))
                } catch{
                    completion(.failure(.decodingError))
                }
            case .failure(_):
                completion(.failure(.decodingError))
            }
        }
    }
    
    
    
    func getUsers() async -> Result<[User],APIError>{
            let dataa = await NetworkLayer.shared.makeGetRequest(urlString: urlStr)
            switch dataa{
            case .success(let data):
                let decodedData = try? JSONDecoder().decode(UsersResponse.self, from: data)
                return  .success(decodedData?.users ?? [])
            case .failure(let error):
                return .failure(.decodingError)
            } 
    }
    
}

//how to check session
