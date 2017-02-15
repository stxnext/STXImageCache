//
//  STXMemoryCacheConfig.swift
//  STXImageCache
//
//  Created by Norbert Sroczyński on 08.02.2017.
//  Copyright © 2017 STX Next Sp. z o.o. All rights reserved.
//

import Foundation

/// A `STXMemoryCacheConfig` structure defines the behavior and policy of memory caching.
public struct STXMemoryCacheConfig {
    /// A Boolean value indicating memory caching
    public var enabled: Bool
    /// The maximum size (in megabytes) of memory designed to cache
    public var maximumMemoryCacheSize: UInt
    
    /// Creates and returns a new `STXMemoryCacheConfig` structure specified by a given parameters.
    public init(enabled: Bool = true, maximumMemoryCacheSize: UInt = 5) {
        self.enabled = enabled
        self.maximumMemoryCacheSize = maximumMemoryCacheSize
    }
}
