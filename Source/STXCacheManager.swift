//
//  STXCacheManager.swift
//  STXImageCache
//
//  Created by Norbert Sroczyński on 07.02.2017.
//  Copyright © 2017 STX Next Sp. z o.o. All rights reserved.
//

import Foundation

/// Main manager class of STXImageCache.
/// It connects STXImageCache downloader and cache.
/// You can use this class to retrieve an image via a specified URL from web or cache.
public final class STXCacheManager {
    /// Returns the shared STXCacheManager object.
    public static let shared = STXCacheManager()
    private let operationQueue: OperationQueue = {
        var operationQueue = OperationQueue()
        operationQueue.maxConcurrentOperationCount = 10
        return operationQueue
    }()
    private let serialQueue = DispatchQueue(label: "Serial queue")
    
    /// Configuration structure for disk caching.
    public var diskCacheConfig: STXDiskCacheConfig = STXDiskCacheConfig() {
        didSet {
            provider = nil
        }
    }
    /// Configuration structure for memory caching.
    public var memoryCacheConfig: STXMemoryCacheConfig = STXMemoryCacheConfig() {
        didSet {
            provider = nil
        }
    }
    
    private lazy var _provider: Providing! = {
        var rootProvider: Providing = NetworkProvider()
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
    
    /**
     Get an image at URL.
     `STXCacheManager` will seek the image in memory and disk first.
     If not found, it will download the image at from given URL and cache it.
     
     - parameter url:               URL for the image
     - parameter forceRefresh:      A Boolean value indicating whether the operation should force refresh
     - parameter progress:          Periodically informs about the download’s progress.
     - parameter completion:        Called when the whole retrieving process finished.
     
     - returns: A `STXImageOperation` task object. You can use this object to cancel the task.
    */
    @discardableResult
    public func image(atURL url: URL, forceRefresh: Bool = false, progress: STXImageCacheProgress? = nil, completion: @escaping STXImageOperationCompletion) -> STXImageOperation {
        let task = Task(
            url: url,
            forceRefresh: forceRefresh,
            provider: provider,
            progress: progress,
            completion: completion
        )
        let operation = STXImageOperation(task: task)
        operationQueue.addOperation(task)
        return operation
    }
    
    /// Removes all images from cache.
    public func clearCache() {
        provider = nil
        StorageProvider(childProvider: nil).clearCache()
    }
}
