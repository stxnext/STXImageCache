//
//  ThreadsManager.swift
//  STXImageCache
//
//  Created by Norbert Sroczyński on 09.02.2017.
//  Copyright © 2017 STX Next Sp. z o.o. All rights reserved.
//

import Foundation

final class ThreadsManager<Object: Hashable> {
    private let semaphore = DispatchSemaphore(value: 1)
    private var semaphores: [Object: DispatchSemaphore] = [:]
    
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
