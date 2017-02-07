//
//  NetworkManagerError.swift
//  STXImageCacheDemo
//
//  Created by Norbert Sroczyński on 07.02.2017.
//  Copyright © 2017 STX Next Sp. z o.o. All rights reserved.
//

import Foundation

enum NetworkManagerError: Error {
    case connectionError(error: Error)
    case serverError(error: [String])
    case noResponse
}
