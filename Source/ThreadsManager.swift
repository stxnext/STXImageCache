//
//  ThreadsManager.swift
//  STXImageCache
//
//  Created by Norbert Sroczyński on 09.02.2017.
//  Copyright © 2017 STX Next Sp. z o.o. All rights reserved.
//

import Foundation

/// ThreadsManager provides an efficient implementation of a synchronizing mechanism, which can be used to mediate access to an application’s global data or to protect a critical section of code, allowing it to run atomically.
final class ThreadsManager<Object: Hashable> {
    private let semaphore = DispatchSemaphore(value: 1)
    private var semaphores: [Object: DispatchSemaphore] = [:]
    
    /// Attempts to acquire a lock for given object, blocking a thread’s execution until the lock can be acquired.
    func lock(forObject object: Object) {
        semaphore.wait()
        guard let lock = semaphores[object] else {
            semaphores[object] = DispatchSemaphore(value: 0)
            semaphore.signal()
            return
        }
        semaphore.signal()
        lock.wait()
    }
    
    /// Relinquishes a previously acquired lock for given object
    func unlock(forObject object: Object) {
        semaphore.wait()
        guard let lock = semaphores[object] else {
            semaphore.signal()
            return
        }
        semaphore.signal()
        lock.signal()
    }
}
