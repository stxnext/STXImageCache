//
//  HTTPResponseSuccess.swift
//  STXImageCacheDemo
//
//  Created by Norbert Sroczyński on 07.02.2017.
//  Copyright © 2017 STX Next Sp. z o.o. All rights reserved.
//

import Foundation

enum HTTPResponseSuccess {
    case ok
    case created
    case accepted
    case nonAuthoritativeInformation
    case noContent
    case resetContent
    case partialContent
    case otherSuccessCode(code: Int)
    
    init?(fromStatusCode code: Int) {
        switch code {
        case 200:
            self = .ok
        case 201:
            self = .created
        case 202:
            self = .accepted
        case 203:
            self = .nonAuthoritativeInformation
        case 204:
            self = .noContent
        case 205:
            self = .resetContent
        case 206:
            self = .partialContent
        case 207...299:
            self = .otherSuccessCode(code: code)
        default:
            return nil
        }
    }
}
