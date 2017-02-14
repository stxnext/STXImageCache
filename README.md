<p align="center" >
  <img src="STXImageCache_Logo.png" title="STXImageCache Logo" float=left>
</p>

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Pod Version](http://img.shields.io/cocoapods/v/STXImageCache.svg?style=flat)](http://cocoadocs.org/docsets/STXImageCache/)
[![Pod Platform](http://img.shields.io/cocoapods/p/STXImageCache.svg?style=flat)](http://cocoadocs.org/docsets/SDWebImage/)
[![Pod License](http://img.shields.io/cocoapods/l/STXImageCache.svg?style=flat)](https://www.apache.org/licenses/LICENSE-2.0.html)
[![codebeat badge](https://codebeat.co/badges/600daf29-42bc-47d7-9bc4-79cceced5185)](https://codebeat.co/projects/github-com-stxnext-stximagecache)

STXImageCache is a lightweight, pure-Swift, easy to use library for downloading and caching images. It provides convenient UI extensions. It's inspired by popular libraries like Kingfisher and SDWebImage.

## Features

- [x] UI extensions
- [x] An asynchronous image downloader
- [x] Cancelable downloading tasks
- [x] Memory caching
- [x] Disk caching
- [x] A guarantee that the same URL won't be downloaded several times
- [x] High performance
- [x] Use GCD and ARC

## Requirements

- iOS 9.0 or later
- tvOS 9.0 or later
- watchOS 2.0 or later
- macOS 10.10 or later
- Xcode 8.0 or later

## Installation
#### Cocoapods
```
pod 'STXImageCache', '~> 1.0.0'
```
#### Carthage
```
github "stxnext/STXImageCache" ~> 1.0.0
```
## Getting Started

### Simplest usage
```swift
let url = URL(string: "image_url")!
imageView.stx.image(atURL: url)
```

### Advanced usage
```swift
let url = URL(string: "image_url")!
let placeholder = UIImage(named: "placeholder")
let operation = imageView.stx.image(atURL: url, placeholder: placeholder, progress: { progress in
        // update progressView
    }, completion: { image, _ in
        // do image processing
        return image
    })
```

### Using with UITableViewCell
```swift
import UIKit
import STXImageCache

final class Cell: UITableViewCell {
    var operation: STXImageOperation?
    @IBOutlet weak var progress: UIProgressView!

    override func prepareForReuse() {
        super.prepareForReuse()
        operation?.cancel()
    }

    func configure(withURL url: URL, placeholder: UIImage) {
        imageView?.image = nil
        progress.progress = 0
        self.progress.isHidden = false
        operation = imageView?.stx.image(atURL: url, placeholder: placeholder, progress: { progress in
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
```

## Author
- [Norbert Sroczyński](https://github.com/orbitekk)

## Communication

- If you **found a bug**, open an issue.
- If you **have a feature request**, open an issue.
- If you **want to contribute**, submit a pull request.

## Licenses

All source code is licensed under the [MIT License](https://raw.github.com/stxnext/STXImageCache/master/LICENSE).
