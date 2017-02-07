//
//  ViewController.swift
//  STXImageCacheDemo-macOS
//
//  Created by Norbert Sroczyński on 07.02.2017.
//  Copyright © 2017 STX Next Sp. z o.o. All rights reserved.
//

import Cocoa
import STXImageCache

class ViewController: NSViewController {
    @IBOutlet private weak var firstImageView: NSImageView!
    @IBOutlet weak var button: UIButton!
    @IBOutlet private weak var button: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "https://s3-us-west-1.amazonaws.com/powr/defaults/image-slider2.jpg")!
        firstImageView.stx.image(atURL: url)
        button.stx.image(atURL: url)
    }
}

