//
//  STXImageCache+NSButtonExtensions.swift
//  STXImageCache
//
//  Created by Norbert Sroczyński on 07.02.2017.
//  Copyright © 2017 STX Next Sp. z o.o. All rights reserved.
//

import AppKit

extension STXImageCache where Base: Button {
    public func image(atURL url: URL) {
        CacheManager.shared.image(atURL: url) { data, error in
            if let data = data {
                DispatchQueue.main.async {
                    self.base.image = Image(data: data)
                }
            }
        }
    }
}