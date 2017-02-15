//
//  FakeProvider.swift
//  STXImageCache
//
//  Created by Norbert Sroczyński on 14.02.2017.
//  Copyright © 2017 STX Next Sp. z o.o. All rights reserved.
//

import Foundation
@testable import STXImageCache

struct FakeProvider: Providing {
    func data() -> Data? {
        return "54522684108592a310d0df06f5276628c0beed730bee020ffeb055f2f69f48ac".data(using: .utf8)
    }
}

extension FakeProvider {
    func get(fromURL url: URL, forceRefresh: Bool, progress: ((Float) -> ())?, completion: @escaping (Data?, NSError?) -> ()) -> URLSessionTask? {
        completion(data(), nil)
        return nil
    }
}
