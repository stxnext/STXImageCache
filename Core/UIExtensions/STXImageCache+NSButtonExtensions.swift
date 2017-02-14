//
//  STXImageCache+NSButtonExtensions.swift
//  STXImageCache
//
//  Created by Norbert Sroczyński on 07.02.2017.
//  Copyright © 2017 STX Next Sp. z o.o. All rights reserved.
//

import AppKit

extension STXImageCache where Base: Button {
    /**
     Get an image at URL.
     `STXCacheManager` will seek the image in memory and disk first.
     If not found, it will download the image at from given URL and cache it.
     
     - parameter url:               URL for the image
     - parameter placeholder:       An image that is used during downloading image
     - parameter forceRefresh:      A Boolean value indicating whether the operation should force refresh
     - parameter progress:          Periodically informs about the download’s progress.
     - parameter completion:        Called when the whole retrieving process finished.
     
     - returns: A `STXImageOperation` task object. You can use this object to cancel the task.
    */
    @discardableResult
    public func image(atURL url: URL, placeholder: Image? = nil, forceRefresh: Bool = false, progress: STXImageCacheProgress? = nil, completion: STXImageCacheCompletion? = nil) -> STXImageOperation {
        if let placeholderImage = placeholder {
            self.base.image = placeholderImage
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
                self.base.image = image
            }
        }
    }
}
