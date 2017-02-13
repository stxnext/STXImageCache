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
        memoryCache.totalCostLimit = Int(self.maximumMemoryCacheSize)
    }
    
    fileprivate func getFromChildProvider(fromURL url: URL, forceRefresh: Bool, progress: ((Float) -> ())?, completion: @escaping (Data?, NSError?) -> ()) -> URLSessionTask? {
        guard let childProvider = childProvider else {
            self.threadsManager.unlock(forObject: url)
            completion(nil, nil)
            return nil
        }
        return childProvider.get(fromURL: url, forceRefresh: forceRefresh, progress: progress) { data, error in
            if let data = data {
                self.store(data: data, atURL: url)
            }
            self.threadsManager.unlock(forObject: url)
            completion(data, error)
        }
    }
    
    private func store(data: Data, atURL url: URL) {
        memoryCache.setObject(data as NSData, forKey: url as NSURL, cost: data.count)
    }
}

extension MemoryProvider {
    func get(fromURL url: URL, forceRefresh: Bool, progress: ((Float) -> ())?, completion: @escaping (Data?, NSError?) -> ()) -> URLSessionTask? {
        if forceRefresh && childProvider != nil {
            return getFromChildProvider(fromURL: url, forceRefresh: forceRefresh, progress: progress, completion: completion)
        }
        threadsManager.lock(forObject: url)
        guard
            let data = memoryCache.object(forKey: url as NSURL)
        else {
            return getFromChildProvider(fromURL: url, forceRefresh: forceRefresh, progress: progress, completion: completion)
        }
        threadsManager.unlock(forObject: url)
        completion(data as Data, nil)
        return nil
    }
}
