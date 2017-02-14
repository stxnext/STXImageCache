//
//  FakeNetworkProvider.swift
//  STXImageCache
//
//  Created by Norbert Sroczyński on 14.02.2017.
//  Copyright © 2017 STX Next Sp. z o.o. All rights reserved.
//

import Foundation
@testable import STXImageCache

struct FakeNetworkProvider: Providing {}

extension FakeNetworkProvider {
    func get(fromURL url: URL, forceRefresh: Bool, progress: ((Float) -> ())?, completion: @escaping (Data?, NSError?) -> ()) -> URLSessionTask? {
        let task = URLSession.shared.dataTask(with: url, completionHandler: { data, respose, error in
            completion(data, error as? NSError)
        })
        task.resume()
        return task
    }
}
