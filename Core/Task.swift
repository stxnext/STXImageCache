//
//  Task.swift
//  STXImageCache
//
//  Created by Norbert Sroczyński on 09.02.2017.
//  Copyright © 2017 STX Next Sp. z o.o. All rights reserved.
//

import Foundation

final class Task: Operation {
    let url: URL
    let forceRefresh: Bool
    let provider: Providing
    let completion: STXImageOperationCompletion
    var urlSessionTask: URLSessionTask?
    
    init(url: URL, forceRefresh: Bool, provider: Providing, completion: @escaping STXImageOperationCompletion) {
        self.url = url
        self.forceRefresh = forceRefresh
        self.provider = provider
        self.completion = completion
    }
    
    override func main() {
        if isCancelled {
            return
        }
        let semaphore = DispatchSemaphore(value: 0)
        urlSessionTask = provider.get(fromURL: url, forceRefresh: forceRefresh) { [weak self] data, error in
            guard let strongSelf = self else {
                semaphore.signal()
                return
            }
            if !strongSelf.isCancelled {
                strongSelf.completion(data, error)
            }
            semaphore.signal()
        }
        semaphore.wait()
    }
    
    override func cancel() {
        urlSessionTask?.cancel()
        super.cancel()
    }
}
