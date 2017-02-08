//
//  MemoryProvider.swift
//  STXImageCache
//
//  Created by Norbert Sroczyński on 08.02.2017.
//  Copyright © 2017 STX Next Sp. z o.o. All rights reserved.
//

import Foundation

struct MemoryProvider: Providing {
    fileprivate let memoryCache: NSCache<NSURL, NSData> = {
        var cache = NSCache<NSURL, NSData>()
        cache.countLimit = 100
        cache.totalCostLimit = 1024 * 1024 * 50
        return cache
    }()
    
    let childProvider: Providing?
    
    fileprivate func getFromChildProvider(fromURL url: URL, completion: @escaping (Data?, Error?) -> ()) {
        childProvider?.get(fromURL: url) { data, error in
            if let data = data {
                self.store(data: data, atURL: url)
            }
            completion(data, error)
        }
    }
    
    private func store(data: Data, atURL url: URL) {
        memoryCache.setObject(data as NSData, forKey: url as NSURL, cost: data.count)
    }
}

extension MemoryProvider {
    func get(fromURL url: URL, completion: @escaping (Data?, Error?) -> ()) {
        guard
            let data = memoryCache.object(forKey: url as NSURL)
        else {
            getFromChildProvider(fromURL: url, completion: completion)
            return
        }
        completion(data as Data, nil)
    }
}
