//
//  STXImageCache+UIButtonExtensions.swift
//  STXImageCache
//
//  Created by Norbert Sroczyński on 07.02.2017.
//  Copyright © 2017 STX Next Sp. z o.o. All rights reserved.
//

import UIKit

extension STXImageCache where Base: Button {
    public func image(atURL url: URL, controlState: UIControlState = .normal, renderingMode: UIImageRenderingMode = .alwaysOriginal) {
        image(atURL: url) { image, error in
            self.base.setImage(image?.withRenderingMode(renderingMode), for: controlState)
        }
    }
    
    public func backgroundImage(atURL url: URL, controlState: UIControlState = .normal, renderingMode: UIImageRenderingMode = .alwaysOriginal) {
        image(atURL: url) { image, error in
            self.base.setBackgroundImage(image?.withRenderingMode(renderingMode), for: controlState)
        }
    }
    
    private func image(atURL url: URL, completion: @escaping (Image?, Error?) -> ()) {
        STXCacheManager.shared.image(atURL: url) { data, error in
            if let data = data {
                DispatchQueue.main.async {
                    completion(Image(data: data), error)
                }
            }
        }
    }
}
