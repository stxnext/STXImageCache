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
    
    private lazy var provider: Providing! = {
        var rootProvider: Providing = NetworkProvider(childProvider: nil)
        if self.diskCacheConfig.enabled {
            rootProvider = StorageProvider(childProvider: rootProvider, expirationTime: self.diskCacheConfig.diskExpirationTime)
        }
        if self.memoryCacheConfig.enabled {
            rootProvider = MemoryProvider(childProvider: rootProvider, maximumMemoryCacheSize: self.memoryCacheConfig.maximumMemoryCacheSize)
        }
        return rootProvider
    }()
    
    func image(atURL url: URL, completion: @escaping STXCacheManagerCompletion) {
        provider.get(fromURL: url, completion: completion)
    }
}
