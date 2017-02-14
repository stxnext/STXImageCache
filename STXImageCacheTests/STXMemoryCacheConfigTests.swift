//
//  STXMemoryCacheConfigTests.swift
//  STXImageCache
//
//  Created by Norbert Sroczyński on 14.02.2017.
//  Copyright © 2017 STX Next Sp. z o.o. All rights reserved.
//

import XCTest
@testable import STXImageCache

class STXMemoryCacheConfigTests: XCTestCase {
    func testDefaultMemoryCacheConfig() {
        let config = STXMemoryCacheConfig()
        XCTAssertNotNil(config, "Config doesn't exists")
        XCTAssertEqual(config.enabled, true, "Default value is different")
        XCTAssertEqual(config.maximumMemoryCacheSize, 5, "Default value is different")
    }
    
    func testCustomMemoryCacheConfig() {
        let enabled = false
        let maximumMemoryCacheSize: UInt = 12
        
        let config = STXMemoryCacheConfig(enabled: enabled, maximumMemoryCacheSize: maximumMemoryCacheSize)
        XCTAssertNotNil(config, "Config doesn't exists")
        XCTAssertEqual(config.enabled, enabled, "Enabled value is different")
        XCTAssertEqual(config.maximumMemoryCacheSize, maximumMemoryCacheSize, "MaximumMemoryCacheSize value is different")
    }
}
