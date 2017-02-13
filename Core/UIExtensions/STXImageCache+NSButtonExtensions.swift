//
//  STXImageCache+NSButtonExtensions.swift
//  STXImageCache
//
//  Created by Norbert Sroczyński on 07.02.2017.
//  Copyright © 2017 STX Next Sp. z o.o. All rights reserved.
//

import AppKit

extension STXImageCache where Base: Button {
    @discardableResult
    public func image(atURL url: URL, placeholder: Image? = nil, forceRefresh: Bool = false, progress: STXImageCacheProgress? = nil, completion: STXImageCacheCompletion? = nil) -> STXImageOperation {
        if let placeholderImage = placeholder {
            self.setImage(image: placeholderImage)
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
}
