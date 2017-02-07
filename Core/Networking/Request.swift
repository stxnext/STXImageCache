//
//  Request.swift
//  STXImageCacheDemo
//
//  Created by Norbert Sroczyński on 07.02.2017.
//  Copyright © 2017 STX Next Sp. z o.o. All rights reserved.
//

import Foundation

protocol Request {
    var url: URL {get}
    var headers: [String: String]? {get}
    var contentType: String {get}
}
