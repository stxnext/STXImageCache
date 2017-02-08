//
//  CacheManager.swift
//  STXImageCache
//
//  Created by Norbert Sroczyński on 07.02.2017.
//  Copyright © 2017 STX Next Sp. z o.o. All rights reserved.
//

import Foundation

typealias CacheManagerCompletion = (Data?, Error?) -> ()

final class CacheManager {
    static let shared = CacheManager()
    
    let provider: Providing = NetworkProvider(childProvider: nil)
    
    func image(atURL url: URL, completion: @escaping CacheManagerCompletion) {
        provider.get(fromURL: url, completion: completion)
    }
}
