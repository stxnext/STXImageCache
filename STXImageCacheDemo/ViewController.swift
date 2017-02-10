//
//  ViewController.swift
//  STXImageCacheDemo
//
//  Created by Norbert Sroczyński on 07.02.2017.
//  Copyright © 2017 STX Next Sp. z o.o. All rights reserved.
//

import UIKit
import STXImageCache

class ViewController: UIViewController {
    @IBOutlet private weak var firstImageView: UIImageView!
    @IBOutlet private weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Default configuration
        var diskConfig = STXDiskCacheConfig()
        diskConfig.enabled = true
        diskConfig.cacheExpirationTime = 7 // in days, 0 = never (dependent on iOS)
        STXCacheManager.shared.diskCacheConfig = diskConfig
        
        var memoryConfig = STXMemoryCacheConfig()
        
        memoryConfig.enabled = true
        memoryConfig.maximumMemoryCacheSize = 5 // in megabytes, 0 = unlimited
        STXCacheManager.shared.memoryCacheConfig = memoryConfig
        // ---------------------
        
        let url = URL(string: "https://s3-us-west-1.amazonaws.com/powr/defaults/image-slider2.jpg")!
        firstImageView.stx.image(atURL: url)
        button.stx.image(atURL: url)
        
        STXCacheManager.shared.image(atURL: url) { data, error in
            guard let data = data else {
                return
            }
            _ = UIImage(data: data)
        }
    }
}

