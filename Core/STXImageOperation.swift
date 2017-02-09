//
//  STXImageOperation.swift
//  STXImageCache
//
//  Created by Norbert Sroczyński on 09.02.2017.
//  Copyright © 2017 STX Next Sp. z o.o. All rights reserved.
//

import Foundation

public typealias STXImageOperationCompletion = (Data?, Error?) -> ()

public struct STXImageOperation {
    public var url: URL {
        return task.url
    }
    public var forceRefresh: Bool {
        return task.forceRefresh
    }
    public var isFinished: Bool {
        return task.isFinished
    }
    public var isExecuting: Bool {
        return task.isExecuting
    }
    public var isCancelled: Bool {
        return task.isCancelled
    }
    private let task: Task
    
    init(task: Task) {
        self.task = task
    }
    
    public func cancel() {
        task.cancel()
    }
}
