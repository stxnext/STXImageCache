//
//  STXImageCache.swift
//  STXImageCache
//
//  Created by Norbert Sroczyński on 07.02.2017.
//  Copyright © 2017 STX Next Sp. z o.o. All rights reserved.
//

import Foundation

public typealias STXImageCacheCompletion = (Image?, NSError?) -> (Image?)

public struct STXImageCache<Base> {
    let base: Base
    init(_ base: Base) {
        self.base = base
    }
}

public protocol STXImageCacheCompatible {
    associatedtype Compatible
    var stx: Compatible { get }
}

public extension STXImageCacheCompatible {
    public var stx: STXImageCache<Self> {
        return STXImageCache(self)
    }
}

extension ImageView: STXImageCacheCompatible {}
#if !os(watchOS)
extension Button: STXImageCacheCompatible {}
#endif
