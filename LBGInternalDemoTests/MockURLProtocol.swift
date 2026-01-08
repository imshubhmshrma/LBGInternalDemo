//
//  MockU.swift
//  LBGInternalDemo
//
//  Created by Shubham Sharma on 29/12/25.
//

import Foundation


class MockURLProtocol: URLProtocol{
    
    static var mockResponse: HTTPURLResponse?
    static var mockData: Data?
    static var mockError: Error?
    
    func stubResponse(response: HTTPURLResponse?, data: Data?, error: Error?) {
        MockURLProtocol.mockData = data
        MockURLProtocol.mockResponse = response
        MockURLProtocol.mockError = error
    }
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    override func startLoading() {
        guard let client = client else { return }
        
        
        if let error = MockURLProtocol.mockError {
            client.urlProtocol(self, didFailWithError: error)
        }
        
        if let response = MockURLProtocol.mockResponse{
            client.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        }
        if let data = MockURLProtocol.mockData{
            client.urlProtocol(self, didLoad: data)
        }else {
            client.urlProtocol(self, didLoad: Data())
        }
        
        client.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() { }
}



