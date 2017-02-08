//
//  STXMemoryCacheConfig.swift
//  STXImageCache
//
//  Created by Norbert Sroczyński on 08.02.2017.
//  Copyright © 2017 STX Next Sp. z o.o. All rights reserved.
//

import Foundation

public struct STXMemoryCacheConfig {
    public var enabled: Bool
    public var maximumMemoryCacheSize: UInt
    
    public init(enabled: Bool = true, maximumMemoryCacheSize: UInt = 0) {
        self.enabled = enabled
        self.maximumMemoryCacheSize = maximumMemoryCacheSize
    }
}
