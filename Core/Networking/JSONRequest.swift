//
//  JSONRequest.swift
//  STXImageCacheDemo
//
//  Created by Norbert Sroczyński on 07.02.2017.
//  Copyright © 2017 STX Next Sp. z o.o. All rights reserved.
//

import Foundation

struct JSONRequest: Request {
    let url: URL
    let headers: [String: String]?
    let contentType: String
    
    init(url: URL, queryParameters: [String: String]? = nil, headers: [String: String]? = nil) {
        contentType = "application/json"
        self.url = JSONRequest.requestURL(url: url, queryParameters: queryParameters)
        self.headers = headers
    }
    
    static private func requestURL(url: URL, queryParameters: [String: String]?) -> URL {
        guard
            let queryParameters = queryParameters,
            var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        else {
            return url
        }
        let queryItems = QueryItemsConverter.queryItems(fromParameters: queryParameters)
        urlComponents.queryItems = queryItems + (urlComponents.queryItems ?? [])
        return urlComponents.url ?? url
    }
}
