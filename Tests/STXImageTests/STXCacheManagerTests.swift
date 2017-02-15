//
//  STXCacheManagerTests.swift
//  STXImageCache
//
//  Created by Norbert Sroczyński on 14.02.2017.
//  Copyright © 2017 STX Next Sp. z o.o. All rights reserved.
//

import XCTest
@testable import STXImageCache

class STXCacheManagerTests: XCTestCase {
    func testSharedManager() {
        let manager = STXCacheManager.shared
        XCTAssertNotNil(manager, "Shared manager doesn't exists")
        XCTAssertNotNil(manager.diskCacheConfig, "diskCacheConfig doesn't exists")
        XCTAssertNotNil(manager.memoryCacheConfig, "memoryCacheConfig doesn't exists")
    }
}
