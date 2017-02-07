//
//  ViewController.swift
//  STXImageCacheDemo-tvOS
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
        let url = URL(string: "https://s3-us-west-1.amazonaws.com/powr/defaults/image-slider2.jpg")!
        firstImageView.stx.image(atURL: url)
        button.stx.backgroundImage(atURL: url)
    }
}

