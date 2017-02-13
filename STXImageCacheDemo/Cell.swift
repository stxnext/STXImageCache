//
//  Cell.swift
//  LibTest
//
//  Created by Norbert Sroczyński on 09.02.2017.
//  Copyright © 2017 STX Next Sp. z o.o. All rights reserved.
//

import UIKit
import STXImageCache

final class Cell: UITableViewCell {
    var operation: STXImageOperation?
    @IBOutlet weak var img: UIImageView!
    
    override func prepareForReuse() {
        operation?.cancel()
        img.image = nil
    }
    
    func configure(url: String) {
        operation = img.stx.image(atURL: URL(string: url)!, placeholder: UIImage(named: "placeholder"))
    }
}
