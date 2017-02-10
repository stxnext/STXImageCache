//
//  Providing.swift
//  STXImageCache
//
//  Created by Norbert Sroczyński on 07.02.2017.
//  Copyright © 2017 STX Next Sp. z o.o. All rights reserved.
//

import Foundation

protocol Providing {
    var childProvider: Providing? { get }
    func get(fromURL url: URL, forceRefresh: Bool, completion: @escaping (Data?, NSError?) -> ()) -> URLSessionTask?
}
