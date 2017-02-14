//
//  NetworkProvider.swift
//  STXImageCache
//
//  Created by Norbert Sroczyński on 07.02.2017.
//  Copyright © 2017 STX Next Sp. z o.o. All rights reserved.
//

import Foundation

struct NetworkProvider: Providing {
    fileprivate let imageDownloader: ImageDownloader
    
    init(imageDownloader: ImageDownloader = ImageDownloader()) {
        self.imageDownloader = imageDownloader
    }
}

extension NetworkProvider {
    func get(fromURL url: URL, forceRefresh: Bool, progress: ((Float) -> ())?, completion: @escaping (Data?, NSError?) -> ()) -> URLSessionTask? {
        if url.isFileURL {
            completion(nil, nil)
            return nil
        }
        return imageDownloader.download(fromURL: url, progress: progress, completion: completion)
    }
}
