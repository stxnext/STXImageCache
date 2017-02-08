//
//  STXImageCache+UIButtonExtensions.swift
//  STXImageCache
//
//  Created by Norbert Sroczyński on 07.02.2017.
//  Copyright © 2017 STX Next Sp. z o.o. All rights reserved.
//

import UIKit

extension STXImageCache where Base: Button {
    public func image(atURL url: URL, forceRefresh: Bool = false, controlState: UIControlState = .normal, renderingMode: UIImageRenderingMode = .alwaysOriginal) {
        image(atURL: url, forceRefresh: forceRefresh) { image, error in
            self.base.setImage(image?.withRenderingMode(renderingMode), for: controlState)
        }
    }
    
    public func backgroundImage(atURL url: URL, forceRefresh: Bool = false, controlState: UIControlState = .normal, renderingMode: UIImageRenderingMode = .alwaysOriginal) {
        image(atURL: url, forceRefresh: forceRefresh) { image, error in
            self.base.setBackgroundImage(image?.withRenderingMode(renderingMode), for: controlState)
        }
    }
    
    private func image(atURL url: URL, forceRefresh: Bool = false, completion: @escaping (Image?, Error?) -> ()) {
        STXCacheManager.shared.image(atURL: url, forceRefresh: forceRefresh) { data, error in
            if let data = data {
                DispatchQueue.main.async {
                    completion(Image(data: data), error)
                }
            }
        }
    }
}
