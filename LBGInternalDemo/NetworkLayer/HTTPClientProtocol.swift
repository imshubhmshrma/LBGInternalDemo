//
//  HTTPClientProtocol.swift
//  LBGInternalDemo
//
//  Created by Shubham Sharma on 26/12/25.
//

import Foundation

protocol NetworkClientProtocol{
    func makeGetReques<T: Codable> (url: URL, completion: @escaping (Result<T,APIError>) -> Void)
}
