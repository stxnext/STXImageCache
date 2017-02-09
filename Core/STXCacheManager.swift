//
//  STXCacheManager.swift
//  STXImageCache
//
//  Created by Norbert Sroczyński on 07.02.2017.
//  Copyright © 2017 STX Next Sp. z o.o. All rights reserved.
//

import Foundation

public typealias STXCacheManagerCompletion = (Data?, Error?) -> ()

public final class STXCacheManager {
    public static let shared = STXCacheManager()
    private let concurrentTasksLimit = DispatchSemaphore(value: 10)
    private let concurrentQueue = DispatchQueue(label: "Operation queue", qos: .background, attributes: .concurrent)
    private let serialQueue = DispatchQueue(label: "Serial queue")
    
    public var diskCacheConfig: STXDiskCacheConfig = STXDiskCacheConfig() {
        didSet {
            provider = nil
        }
    }
    public var memoryCacheConfig: STXMemoryCacheConfig = STXMemoryCacheConfig() {
        didSet {
            provider = nil
        }
    }
    
    private lazy var _provider: Providing! = {
        var rootProvider: Providing = NetworkProvider(childProvider: nil)
        if self.diskCacheConfig.enabled {
            rootProvider = StorageProvider(childProvider: rootProvider, expirationTime: self.diskCacheConfig.cacheExpirationTime)
        }
        if self.memoryCacheConfig.enabled {
            rootProvider = MemoryProvider(childProvider: rootProvider, maximumMemoryCacheSize: self.memoryCacheConfig.maximumMemoryCacheSize)
        }
        return rootProvider
    }()
    
    private var provider: Providing! {
        get {
            return serialQueue.sync {
                return _provider
            }
        }
        set {
            serialQueue.sync {
                _provider = newValue
            }
        }
    }
    
    public func image(atURL url: URL, forceRefresh: Bool = false, completion: @escaping STXCacheManagerCompletion) {
        self.concurrentTasksLimit.wait()
        concurrentQueue.async {
            self.provider.get(fromURL: url, forceRefresh: forceRefresh) { data, error in
                completion(data, error)
                self.concurrentTasksLimit.signal()
            }
        }
    }
    
    public func clearCache() {
        provider = nil
        StorageProvider(childProvider: nil).clearCache()
    }
}
