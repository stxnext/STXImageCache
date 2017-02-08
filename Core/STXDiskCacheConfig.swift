//
//  STXDiskCacheConfig.swift
//  STXImageCache
//
//  Created by Norbert Sroczyński on 08.02.2017.
//  Copyright © 2017 STX Next Sp. z o.o. All rights reserved.
//

import Foundation

public struct STXDiskCacheConfig {
    public var enabled: Bool
    public var diskExpirationTime: UInt
    
    public init(enabled: Bool = true, diskExpirationTime: UInt = 7) {
        self.enabled = enabled
        self.diskExpirationTime = diskExpirationTime
    }
}
