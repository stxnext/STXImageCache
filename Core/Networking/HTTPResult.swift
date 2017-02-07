//
//  HTTPResult.swift
//  STXImageCacheDemo
//
//  Created by Norbert Sroczyński on 07.02.2017.
//  Copyright © 2017 STX Next Sp. z o.o. All rights reserved.
//

import Foundation

enum HTTPResult<Object, ErrorObject, ErrorType> {
    case success(code: HTTPResponseSuccess, data: Object)
    case failed(code: Int, data: ErrorObject)
    case error(error: ErrorType)
}
