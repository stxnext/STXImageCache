//
//  STXDiskCacheConfig.swift
//  STXImageCache
//
//  Created by Norbert Sroczyński on 08.02.2017.
//  Copyright © 2017 STX Next Sp. z o.o. All rights reserved.
//

import Foundation

/// A `STXDiskCacheConfig` structure defines the behavior and policy of disk caching.
public struct STXDiskCacheConfig {
    /// A Boolean value indicating disk caching
    public var enabled: Bool
    /// The longest time duration in days of the cache being stored in disk.
    public var cacheExpirationTime: UInt
    
    /// Creates and returns a new `STXDiskCacheConfig` structure specified by a given parameters.
    public init(enabled: Bool = true, cacheExpirationTime: UInt = 7) {
        self.enabled = enabled
        self.cacheExpirationTime = cacheExpirationTime
    }
}
