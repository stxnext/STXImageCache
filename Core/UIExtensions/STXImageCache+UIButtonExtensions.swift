//
//  STXImageCache+UIButtonExtensions.swift
//  STXImageCache
//
//  Created by Norbert Sroczyński on 07.02.2017.
//  Copyright © 2017 STX Next Sp. z o.o. All rights reserved.
//

import UIKit

extension STXImageCache where Base: Button {
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
