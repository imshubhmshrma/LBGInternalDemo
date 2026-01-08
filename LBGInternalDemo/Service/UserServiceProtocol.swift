//
//  UserServiceProtocol.swift
//  LBGInternalDemo
//
//  Created by Shubham Sharma on 26/12/25.
//

enum APIError: Error {
    case invalidURL
    case invalidResponse
    case decodingError
    case invalidData
}


protocol UserServiceProtocol{
    func getUsers(completion: @escaping (Result<[User],APIError>) -> Void)
    func getUsers() async -> Result<[User],APIError>
}
