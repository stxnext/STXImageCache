//
//  STXDiskCacheConfigTests.swift
//  STXImageCache
//
//  Created by Norbert Sroczyński on 14.02.2017.
//  Copyright © 2017 STX Next Sp. z o.o. All rights reserved.
//

import XCTest
@testable import STXImageCache

class STXDiskCacheConfigTests: XCTestCase {
    func testDefaultDiskCacheConfig() {
        let config = STXDiskCacheConfig()
        XCTAssertNotNil(config, "Config doesn't exists")
        XCTAssertEqual(config.enabled, true, "Default value is different")
        XCTAssertEqual(config.cacheExpirationTime, 7, "Default value is different")
    }
    
    func testCustomDiskCacheConfig() {
        let enabled = false
        let cacheExpirationTime: UInt = 12
        
        let config = STXDiskCacheConfig(enabled: enabled, cacheExpirationTime: cacheExpirationTime)
        XCTAssertNotNil(config, "Config doesn't exists")
        XCTAssertEqual(config.enabled, enabled, "Enabled value is different")
        XCTAssertEqual(config.cacheExpirationTime, cacheExpirationTime, "CacheExpirationTime value is different")
    }
}
