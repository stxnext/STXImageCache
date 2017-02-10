//
//  HTTPNetworking.swift
//  STXImageCacheDemo
//
//  Created by Norbert Sroczyński on 07.02.2017.
//  Copyright © 2017 STX Next Sp. z o.o. All rights reserved.
//

import Foundation

protocol HTTPNetworking {
    associatedtype Object
    associatedtype ErrorType
    func execute(completion: @escaping (HTTPResult<Object, ErrorType>) -> ()) -> URLSessionTask
}
