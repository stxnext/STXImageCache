//
//  STXImageCache+Extensions.swift
//  STXImageCache
//
//  Created by Norbert Sroczyński on 07.02.2017.
//  Copyright © 2017 STX Next Sp. z o.o. All rights reserved.
//

#if os(macOS)
    import AppKit
#elseif os(watchOS)
    import WatchKit
#else
    import UIKit
#endif

extension STXImageCache where Base: ImageView {
    @discardableResult
    public func image(atURL url: URL, forceRefresh: Bool = false) -> STXImageOperation {
        return STXCacheManager.shared.image(atURL: url, forceRefresh: forceRefresh) { data, error in
            if let data = data {
                DispatchQueue.main.async {
                    self.setImage(image: Image(data: data))
                }
            }
        }
    }
    
    func setImage(image: Image?) {
#if os(watchOS)
        self.base.setImage(image)
#else
        self.base.image = image
#endif
    }
}
