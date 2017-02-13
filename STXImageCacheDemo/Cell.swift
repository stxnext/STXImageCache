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
    @IBOutlet weak var progress: UIProgressView!
    
    override func prepareForReuse() {
        operation?.cancel()
        img.image = nil
    }
    
    func configure(url: String) {
        progress.progress = 0
        self.progress.isHidden = false
        operation = img.stx.image(atURL: URL(string: url)!, placeholder: UIImage(named: "placeholder"), progress: { progress in
            DispatchQueue.main.async {
                self.progress.setProgress(progress, animated: true)
            }
        }, completion: { image, _ in
            DispatchQueue.main.async {
                self.progress.isHidden = true
            }
            return image
        })
    }
}
