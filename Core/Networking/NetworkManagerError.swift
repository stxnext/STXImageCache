//
//  NetworkManagerError.swift
//  STXImageCacheDemo
//
//  Created by Norbert Sroczyński on 07.02.2017.
//  Copyright © 2017 STX Next Sp. z o.o. All rights reserved.
//

import Foundation

enum NetworkManagerError: CustomNSError {
    case connectionError(error: Error)
    case noResponse
    
    var errorUserInfo: [String : Any] {
        switch self {
        case .connectionError(error: let error):
            let cocoaError = error as NSError
            return cocoaError.userInfo as? [String: Any] ?? [:]
        case .noResponse:
            return [NSLocalizedDescriptionKey: "No response"]
        }
    }
    
    var errorCode: Int {
        switch self {
        case .connectionError(error: let error):
            let cocoaError = error as NSError
            return cocoaError.code
        case .noResponse:
            return -1
        }
    }
}
