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
    
    func image(atURL url: URL, completion: @escaping CacheManagerCompletion) {
        let request = JSONRequest(url: url)
        let _ = NetworkManager.GET(request: request).execute { result in
            switch result {
            case .error(error: let error):
                completion(nil, error)
            case .failed(code: let code, description: let description):
                let error = NSError(domain: "com.stxnext.STXImageCache.HTTPError", code: code, userInfo: [NSLocalizedDescriptionKey: description])
                completion(nil, error)
            case .success(code: _, data: let data):
                completion(data, nil)
            }
        }
    }
}
