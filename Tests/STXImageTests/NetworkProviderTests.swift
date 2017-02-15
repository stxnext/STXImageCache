//
//  NetworkProviderTests.swift
//  STXImageCache
//
//  Created by Norbert Sroczyński on 14.02.2017.
//  Copyright © 2017 STX Next Sp. z o.o. All rights reserved.
//

import XCTest
@testable import STXImageCache

class NetworkProviderTests: XCTestCase {
    func testNetworkProvider() {
        let url = URL(string: "https://raw.githubusercontent.com/stxnext/STXImageCache/master/STXImageCache_Logo.png")!
        let imageData = try? Data(contentsOf: url)
        
        let downloadExpectation = expectation(description: "download expectation")
        
        let provider = NetworkProvider(imageDownloader: ImageDownloader(configuration: URLSessionConfiguration.default))
        _ = provider.get(fromURL: url, forceRefresh: false, progress: nil) { data, error in
            XCTAssertEqual(imageData, data, "data is different")
            XCTAssertNil(error, "error should be nil")
            downloadExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 30)
    }
}
