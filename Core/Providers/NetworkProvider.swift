//
//  NetworkProvider.swift
//  STXImageCache
//
//  Created by Norbert Sroczyński on 07.02.2017.
//  Copyright © 2017 STX Next Sp. z o.o. All rights reserved.
//

import Foundation

struct NetworkProvider: Providing {
    fileprivate let imageDownloader = ImageDownloader()
}

extension NetworkProvider {
    func get(fromURL url: URL, forceRefresh: Bool, completion: @escaping (Data?, NSError?) -> ()) -> URLSessionTask? {
        return imageDownloader.download(fromURL: url) { data, error in
            completion(data, error)
        }
    }
}
