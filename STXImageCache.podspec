Pod::Spec.new do |s|

  s.name         = "STXImageCache"
  s.version      = "1.0.2"
  s.summary      = "A lightweight and pure-Swift library for downloading and caching images."

  s.description  = <<-DESC
                   STXImageCache is a lightweight, pure-Swift, easy to use library for downloading and caching images. It provides convenient UI extensions. It's inspired by popular libraries like Kingfisher and SDWebImage.
                   DESC

  s.homepage     = "https://github.com/stxnext/STXImageCache"

  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.authors            = { "Norbert Sroczyński" => "norbert.sroczynski@stxnext.pl" }

  s.ios.deployment_target = "9.0"
  s.tvos.deployment_target = "9.0"
  s.osx.deployment_target = "10.10"
  s.watchos.deployment_target = "2.0"

  s.source       = { :git => "https://github.com/stxnext/STXImageCache.git", :tag => s.version }

  s.ios.source_files = ["Source/*.swift", "STXImageCache.h"]
  s.watchos.source_files = ["Source/*.swift", "STXImageCache.h"]
  s.tvos.source_files = ["Source/*.swift", "STXImageCache.h"]
  s.osx.source_files = ["Source/*.swift", "STXImageCache.h"]

  s.public_header_files = ["STXImageCache.h"]

  s.osx.exclude_files = ["Source/STXImageCache+UIButtonExtensions.swift"]
  s.watchos.exclude_files = ["Source/STXImageCache+NSButtonExtensions.swift", "Source/STXImageCache+UIButtonExtensions.swift"]
  s.ios.exclude_files = ["Source/STXImageCache+NSButtonExtensions.swift"]
  s.tvos.exclude_files = ["Source/STXImageCache+NSButtonExtensions.swift"]

  s.requires_arc = true

  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '3.0' }
end
