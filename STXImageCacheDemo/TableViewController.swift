//
//  ViewController.swift
//  LibTest
//
//  Created by Norbert Sroczyński on 09.02.2017.
//  Copyright © 2017 STX Next Sp. z o.o. All rights reserved.
//

import UIKit
import STXImageCache

class TableViewController: UITableViewController {

    let images = [
        "http://wowslider.com/sliders/demo-34/data1/images/greatwilder1400498.jpg",
        "http://keenthemes.com/preview/metronic/theme/assets/global/plugins/jcrop/demos/demo_files/image1.jpg",
        "http://kingofwallpapers.com/image/image-006.jpg",
        "https://amazingcarousel.com/wp-content/uploads/amazingcarousel/3/images/lightbox/golden-wheat-field-lightbox.jpg",
        "http://www.gettyimages.in/gi-resources/images/Homepage/Hero/US/MAR2016/prestige-587705839_full.jpg",
        "http://www.gettyimages.ca/gi-resources/images/Homepage/Hero/UK/CMS_Creative_164657191_Kingfisher.jpg",
        "http://cdn.jssor.com/demos/img/photography/005.jpg",
        "http://www.w3schools.com/css/img_fjords.jpg",
        "https://www.smashingmagazine.com/wp-content/uploads/2016/01/07-responsive-image-example-castle-7-opt.jpg",
        "http://kingofwallpapers.com/image/image-023.jpg",
        "http://wowslider.com/sliders/demo-34/data1/images/greatwilder1400498.jpg",
        "http://wowslider.com/sliders/demo-18/data1/images/hongkong1081704.jpg",
        "https://amazingcarousel.com/wp-content/uploads/amazingcarousel/3/images/lightbox/night-in-the-city-lightbox.jpg",
        "http://www.desicomments.com/dc3/09/341913/341913.jpg",
        "http://keenthemes.com/preview/metronic/theme/assets/global/plugins/jcrop/demos/demo_files/image2.jpg",
        "http://beebom.redkapmedia.netdna-cdn.com/wp-content/uploads/2016/01/Reverse-Image-Search-Engines-Apps-And-Its-Uses-2016.jpg"
    ]
    
    override func viewDidLoad() {
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
        
        super.viewDidLoad()
        let nib = UINib(nibName: "Cell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "Cell")
        tableView.rowHeight = tableView.frame.size.width * 3/4
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! Cell
        cell.configure(url: images[indexPath.row])
        return cell
    }
}

