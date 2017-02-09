//
//  MemoryProvider.swift
//  STXImageCache
//
//  Created by Norbert Sroczyński on 08.02.2017.
//  Copyright © 2017 STX Next Sp. z o.o. All rights reserved.
//

import Foundation

struct MemoryProvider: Providing {
    fileprivate let threadsManager = ThreadsManager<URL>()
    fileprivate let memoryCache = NSCache<NSURL, NSData>()
    
    let childProvider: Providing?
    let maximumMemoryCacheSize: UInt
    
    init(childProvider: Providing?, maximumMemoryCacheSize: UInt = 0) {
        self.childProvider = childProvider
        self.maximumMemoryCacheSize = maximumMemoryCacheSize * 1024 * 1024
    }
    
    fileprivate func getFromChildProvider(fromURL url: URL, forceRefresh: Bool, completion: @escaping (Data?, Error?) -> ()) -> URLSessionTask? {
        guard let childProvider = childProvider else {
            completion(nil, nil)
            return nil
        }
        return childProvider.get(fromURL: url, forceRefresh: forceRefresh) { data, error in
            if let data = data {
                self.store(data: data, atURL: url)
                self.threadsManager.unlock(forObject: url)
            }
            completion(data, error)
        }
    }
    
    private func store(data: Data, atURL url: URL) {
        memoryCache.setObject(data as NSData, forKey: url as NSURL, cost: data.count)
    }
}

extension MemoryProvider {
    func get(fromURL url: URL, forceRefresh: Bool, completion: @escaping (Data?, Error?) -> ()) -> URLSessionTask? {
        if forceRefresh && childProvider != nil {
            return getFromChildProvider(fromURL: url, forceRefresh: forceRefresh, completion: completion)
        }
        threadsManager.lock(forObject: url)
        guard
            let data = memoryCache.object(forKey: url as NSURL)
        else {
            return getFromChildProvider(fromURL: url, forceRefresh: forceRefresh, completion: completion)
        }
        threadsManager.unlock(forObject: url)
        completion(data as Data, nil)
        return nil
    }
}
