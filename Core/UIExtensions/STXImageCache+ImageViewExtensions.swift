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
    public func image(atURL url: URL, placeholder: Image? = nil, forceRefresh: Bool = false, completion: STXImageCacheCompletion? = nil) -> STXImageOperation {
        if let placeholderImage = placeholder {
            DispatchQueue.main.async {
                self.setImage(image: placeholderImage)
            }
        }
        return STXCacheManager.shared.image(atURL: url, forceRefresh: forceRefresh) { data, error in
            var image: Image?
            if let data = data {
                image = Image(data: data)
            }
            if let completion = completion {
                image = completion(image, error)
            }
            DispatchQueue.main.async {
                self.setImage(image: image)
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
