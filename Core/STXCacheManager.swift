//
//  STXCacheManager.swift
//  STXImageCache
//
//  Created by Norbert Sroczyński on 07.02.2017.
//  Copyright © 2017 STX Next Sp. z o.o. All rights reserved.
//

import Foundation

public final class STXCacheManager {
    public static let shared = STXCacheManager()
    private let operationQueue: OperationQueue = {
        var operationQueue = OperationQueue()
        operationQueue.maxConcurrentOperationCount = 10
        return operationQueue
    }()
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
            rootProvider = StorageProvider(
                childProvider: rootProvider,
                expirationTime: self.diskCacheConfig.cacheExpirationTime
            )
        }
        if self.memoryCacheConfig.enabled {
            rootProvider = MemoryProvider(
                childProvider: rootProvider,
                maximumMemoryCacheSize: self.memoryCacheConfig.maximumMemoryCacheSize
            )
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
    
    @discardableResult
    public func image(atURL url: URL, forceRefresh: Bool = false, completion: @escaping STXImageOperationCompletion) -> STXImageOperation {
        let task = Task(
            url: url,
            forceRefresh: forceRefresh,
            provider: provider,
            completion: completion
        )
        let operation = STXImageOperation(task: task)
        operationQueue.addOperation(task)
        return operation
    }
    
    public func clearCache() {
        provider = nil
        StorageProvider(childProvider: nil).clearCache()
    }
}
