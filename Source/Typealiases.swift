//
//  Typealiases.swift
//  STXImageCache
//
//  Created by Norbert Sroczyński on 07.02.2017.
//  Copyright © 2017 STX Next Sp. z o.o. All rights reserved.
//

#if os(macOS)
import AppKit
#elseif os(watchOS)
import WatchKit
#else
import UIKit
#endif

#if os(macOS)
public typealias Image = NSImage
public typealias ImageView = NSImageView
public typealias Button = NSButton
#elseif os(watchOS)
public typealias Image = UIImage
public typealias ImageView = WKInterfaceImage
#else
public typealias Image = UIImage
public typealias ImageView = UIImageView
public typealias Button = UIButton
#endif
