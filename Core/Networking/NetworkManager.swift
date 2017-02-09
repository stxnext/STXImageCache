//
//  NetworkManager.swift
//  STXImageCacheDemo
//
//  Created by Norbert Sroczyński on 07.02.2017.
//  Copyright © 2017 STX Next Sp. z o.o. All rights reserved.
//

import Foundation

typealias URLSessionCompletion = (Data?, URLResponse?, Error?) -> ()
typealias NetworkManagerCompletion = (HTTPResult<Data, Data, NetworkManagerError>) -> ()

enum NetworkManager: HTTPNetworking {
    case GET(request: Request)
    
    func execute(completion: @escaping NetworkManagerCompletion) -> URLSessionTask {
        var httpRequest: URLRequest!
        switch self {
        case .GET(request: let request):
            httpRequest = createRequest(request: request, method: .GET)
        }
        return performRequest(urlRequest: httpRequest, completion: completion)
    }
    
    private func createRequest(request: Request, method: HTTPMethod) -> URLRequest {
        var httpRequest = URLRequest(url: request.url)
        httpRequest.httpMethod = method.rawValue
        httpRequest.httpShouldHandleCookies = false
        httpRequest.allHTTPHeaderFields = request.headers
        httpRequest.setValue(request.contentType, forHTTPHeaderField: "Content-Type")
        return httpRequest
    }
    
    private func performRequest(urlRequest: URLRequest, completion: @escaping NetworkManagerCompletion) -> URLSessionTask {
        let urlSession = URLSession.shared
        let urlTask = urlSession.dataTask(with: urlRequest, completionHandler: urlSessionCompletion(completion: completion))
        urlTask.resume()
        return urlTask
    }
    
    private func urlSessionCompletion(completion: @escaping NetworkManagerCompletion) -> URLSessionCompletion {
        return { data, response, error in
            if let error = error {
                completion(.error(error: .connectionError(error: error)))
                return
            }
            guard
                let response = response,
                let data = data
            else {
                completion(.error(error: .noResponse))
                return
            }
            if let successResponse = self.successfulState(fromResponse: response) {
                completion(.success(code: successResponse, data: data))
                return
            }
            //Apple Docs: https://developer.apple.com/reference/foundation/httpurlresponse
            //Whenever you make HTTP URL load requests, any response objects you get back from the URLSession, NSURLConnection, or NSURLDownload class are instances of the NSHTTPURLResponse class.
            let code = (response as! HTTPURLResponse).statusCode
            let description = HTTPURLResponse.localizedString(forStatusCode: code)
            completion(.failed(code: code, description: description))
        }
    }
    
    private func successfulState(fromResponse response: URLResponse) -> HTTPResponseSuccess? {
        guard let httpResponse = response as? HTTPURLResponse else {
            return nil
        }
        return HTTPResponseSuccess(fromStatusCode: httpResponse.statusCode)
    }
}
