<p align="center" >
  <img src="STXImageCache_Logo.png" title="STXImageCache Logo" float=left>
</p>

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

## Getting Started

```swift
let url = URL(string: "image_url")!
imageView.stx.image(atURL: url)
```

### CocoaPods
```
pod 'STXImageCache', '~> 1.0.0'
```

## Author
- [Norbert Sroczyński](https://github.com/orbitekk)

## Communication

- If you **found a bug**, open an issue.
- If you **have a feature request**, open an issue.
- If you **want to contribute**, submit a pull request.

## Licenses

All source code is licensed under the [MIT License](https://raw.github.com/stxnext/STXImageCache/master/LICENSE).
