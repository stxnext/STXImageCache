//
//  Providing.swift
//  STXImageCache
//
//  Created by Norbert Sroczyński on 07.02.2017.
//  Copyright © 2017 STX Next Sp. z o.o. All rights reserved.
//

import Foundation

protocol Providing {
    func get(fromURL url: URL, forceRefresh: Bool, progress: ((Float) -> ())?, completion: @escaping (Data?, NSError?) -> ()) -> URLSessionTask?
}
