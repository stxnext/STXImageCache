//
//  STXImageCache.swift
//  STXImageCache
//
//  Created by Norbert Sroczyński on 07.02.2017.
//  Copyright © 2017 STX Next Sp. z o.o. All rights reserved.
//

import Foundation

/// Completion block of downloader.
public typealias STXImageCacheCompletion = (Image?, NSError?) -> (Image?)
/// Progress update block of downloader.
public typealias STXImageCacheProgress = (Float) -> ()

public struct STXImageCache<Base> {
    /// Base object to extend.
    let base: Base
    /// Creates extensions with base object.
    ///
    /// - parameter base: Base object.
    init(_ base: Base) {
        self.base = base
    }
}

/// A type that has STXImageCache extensions.
public protocol STXImageCacheCompatible {
    associatedtype Compatible
    ///STXImageCache extension
    var stx: Compatible { get }
}

public extension STXImageCacheCompatible {
    ///STXImageCache extension
    public var stx: STXImageCache<Self> {
        return STXImageCache(self)
    }
}

/// Extend ImageView with `stx` proxy.
extension ImageView: STXImageCacheCompatible {}
#if !os(watchOS)
/// Extend Button with `stx` proxy.
extension Button: STXImageCacheCompatible {}
#endif
