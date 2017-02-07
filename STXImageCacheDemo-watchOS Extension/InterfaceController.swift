//
//  InterfaceController.swift
//  STXImageCacheDemo-watchOS Extension
//
//  Created by Norbert Sroczyński on 07.02.2017.
//  Copyright © 2017 STX Next Sp. z o.o. All rights reserved.
//

import WatchKit
import Foundation
import STXImageCache

class InterfaceController: WKInterfaceController {
    @IBOutlet private weak var firstImageView: WKInterfaceImage!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        firstImageView.stx.image(atURL: URL(string: "https://s3-us-west-1.amazonaws.com/powr/defaults/image-slider2.jpg")!)
    }
}
