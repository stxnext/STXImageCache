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
        
        var diskConfig = STXDiskCacheConfig()
        diskConfig.enabled = true
        diskConfig.diskExpirationTime = 7 // in days, 0 = never (dependent on iOS)
        STXCacheManager.shared.diskCacheConfig = diskConfig
        
        var memoryConfig = STXMemoryCacheConfig()
        memoryConfig.enabled = true
        memoryConfig.maximumMemoryCacheSize = 50 // in megabytes, 0 = unlimited
        STXCacheManager.shared.memoryCacheConfig = memoryConfig
        
        for i in 0...1000 {
            let url = URL(string: "https://unsplash.it/200/300/?random")!
            STXCacheManager.shared.image(atURL: url, forceRefresh: true, completion: { data, error in
                if let data = data {
                    print(i)
                }
            })
        }
        
        let url = URL(string: "https://s3-us-west-1.amazonaws.com/powr/defaults/image-slider2.jpg")!
        firstImageView.stx.image(atURL: url)
        button.stx.image(atURL: url)
        
        STXCacheManager.shared.clearCache()
    }
}

