//
//  STXImageOperation.swift
//  STXImageCache
//
//  Created by Norbert Sroczyński on 09.02.2017.
//  Copyright © 2017 STX Next Sp. z o.o. All rights reserved.
//

import Foundation

/// Completion block of operation.
public typealias STXImageOperationCompletion = (Data?, NSError?) -> ()

/// Retrieving operation.
public struct STXImageOperation {
    /// URL for the image
    public var url: URL {
        return task.url
    }
    /// A Boolean value indicating whether the operation should force refresh
    public var forceRefresh: Bool {
        return task.forceRefresh
    }
    /// A Boolean value indicating whether the operation has finished executing its task.
    public var isFinished: Bool {
        return task.isFinished
    }
    /// A Boolean value indicating whether the operation is currently executing.
    public var isExecuting: Bool {
        return task.isExecuting
    }
    /// A Boolean value indicating whether the operation has been cancelled
    public var isCancelled: Bool {
        return task.isCancelled
    }
    
    private let task: Task
    
    init(task: Task) {
        self.task = task
    }
    
    /// Advises the operation object that it should stop executing its task.
    public func cancel() {
        task.cancel()
    }
}
