//
//  QueryItemsConverter.swift
//  STXImageCacheDemo
//
//  Created by Norbert Sroczyński on 07.02.2017.
//  Copyright © 2017 STX Next Sp. z o.o. All rights reserved.
//

import Foundation

struct QueryItemsConverter {
    static func queryItems(fromParameters parameters: [String:String]) -> [URLQueryItem] {
        return parameters.map { (key, value) -> URLQueryItem in
            return URLQueryItem(name: key, value: value)
        }
    }
}
