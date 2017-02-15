//
//  StorageProviderTests.swift
//  STXImageCache
//
//  Created by Norbert Sroczyński on 14.02.2017.
//  Copyright © 2017 STX Next Sp. z o.o. All rights reserved.
//

import XCTest
@testable import STXImageCache

class StorageProviderTests: XCTestCase {
    override func setUp() {
        super.setUp()
        let string = "https://image.png"
        let path = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first!.appending("/STXImageCache/image.png")
        let fileData = string.data(using: .utf8)!
        let fileURL = URL(fileURLWithPath: path)
        
        var directoryURL = fileURL
        directoryURL.deleteLastPathComponent()
        
        do {
            if !FileManager.default.fileExists(atPath: path) {
                try FileManager.default.createDirectory(at: directoryURL, withIntermediateDirectories: true, attributes: nil)
                FileManager.default.createFile(atPath: path, contents: nil, attributes: nil)
            }
            let fileHandler = try FileHandle(forWritingTo: fileURL)
            fileHandler.write(fileData)
        } catch {
            XCTAssert(true)
        }
    }
    
    override func tearDown() {
        let path = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first!.appending("/STXImageCache")
        try? FileManager.default.removeItem(atPath: path)
        super.tearDown()
    }
    
    func testNotExistingFile() {
        let url = URL(string: "https://raw.githubusercontent.com/stxnext/STXImageCache/master/STXImageCache_Logo.png")!
        
        let downloadExpectation = expectation(description: "download expectation")
        
        let provider = StorageProvider(childProvider: nil)
        _ = provider.get(fromURL: url, forceRefresh: false, progress: nil) { data, error in
            XCTAssertNil(data, "data should be nil")
            XCTAssertNil(error, "error should be nil")
            downloadExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1)
    }
    
    func testExistingFile() {
        let string = "https://image.png"
        let url = URL(string: string)!
        let fileData = string.data(using: .utf8)!
        
        let downloadExpectation = expectation(description: "download expectation")
        
        let provider = StorageProvider(childProvider: nil)
        _ = provider.get(fromURL: url, forceRefresh: false, progress: nil) { data, error in
            XCTAssertEqual(data, fileData, "data should be nil")
            XCTAssertNil(error, "error should be nil")
            downloadExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1)
    }
    
    func testClearCache() {
        let provider = StorageProvider(childProvider: nil)
        provider.clearCache()
        
        let string = "https://image.png"
        let url = URL(string: string)!
        
        let downloadExpectation = expectation(description: "download expectation")
        
        _ = provider.get(fromURL: url, forceRefresh: false, progress: nil) { data, error in
            XCTAssertNil(data, "data should be nil")
            XCTAssertNil(error, "error should be nil")
            downloadExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1)
    }
}
