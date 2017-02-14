//
//  STXImageCache+UIButtonExtensions.swift
//  STXImageCache
//
//  Created by Norbert Sroczyński on 07.02.2017.
//  Copyright © 2017 STX Next Sp. z o.o. All rights reserved.
//

import UIKit

extension STXImageCache where Base: Button {
    /**
     Get an image at URL.
     `STXCacheManager` will seek the image in memory and disk first.
     If not found, it will download the image at from given URL and cache it.
     
     - parameter url:               URL for the image
     - parameter placeholder:       An image that is used during downloading image
     - parameter forceRefresh:      A Boolean value indicating whether the operation should force refresh
     - parameter controlState:      The state that uses the specified image.
     - parameter renderingMode:     Determines how an image is rendered.
     - parameter progress:          Periodically informs about the download’s progress.
     - parameter completion:        Called when the whole retrieving process finished.
     
     - returns: A `STXImageOperation` task object. You can use this object to cancel the task.
    */
    @discardableResult
    public func image(atURL url: URL, placeholder: Image? = nil, forceRefresh: Bool = false, controlState: UIControlState = .normal, renderingMode: UIImageRenderingMode = .alwaysOriginal, progress: STXImageCacheProgress? = nil, completion: STXImageCacheCompletion? = nil) -> STXImageOperation {
        return image(atURL: url, forceRefresh: forceRefresh) { image, error in
            var image = image
            if let completion = completion {
                image = completion(image, error)
            }
            DispatchQueue.main.async {
                self.base.setImage(image?.withRenderingMode(renderingMode), for: controlState)
            }
        }
    }
    
    /**
     Get an image at URL.
     `STXCacheManager` will seek the image in memory and disk first.
     If not found, it will download the image at from given URL and cache it.
     
     - parameter url:               URL for the image
     - parameter placeholder:       An image that is used during downloading image
     - parameter forceRefresh:      A Boolean value indicating whether the operation should force refresh
     - parameter controlState:      The state that uses the specified image.
     - parameter renderingMode:     Determines how an image is rendered.
     - parameter progress:          Periodically informs about the download’s progress.
     - parameter completion:        Called when the whole retrieving process finished.
     
     - returns: A `STXImageOperation` task object. You can use this object to cancel the task.
    */
    @discardableResult
    public func backgroundImage(atURL url: URL, placeholder: Image? = nil, forceRefresh: Bool = false, controlState: UIControlState = .normal, renderingMode: UIImageRenderingMode = .alwaysOriginal, progress: STXImageCacheProgress? = nil, completion: STXImageCacheCompletion? = nil) -> STXImageOperation {
        return image(atURL: url, forceRefresh: forceRefresh) { image, error in
            var image = image
            if let completion = completion {
                image = completion(image, error)
            }
            DispatchQueue.main.async {
                self.base.setImage(image?.withRenderingMode(renderingMode), for: controlState)
            }
        }
    }
    
    private func image(atURL url: URL, placeholder: Image? = nil, forceRefresh: Bool, controlState: UIControlState = .normal, renderingMode: UIImageRenderingMode = .alwaysOriginal, progress: STXImageCacheProgress? = nil, completion: @escaping (Image?, NSError?) -> ()) -> STXImageOperation {
        if let placeholderImage = placeholder {
            self.base.setImage(placeholderImage.withRenderingMode(renderingMode), for: controlState)
        }
        return STXCacheManager.shared.image(atURL: url, forceRefresh: forceRefresh, progress: progress) { data, error in
            var image: Image?
            if let data = data {
                image = Image(data: data)
            }
            completion(image, error)
        }
    }
}
