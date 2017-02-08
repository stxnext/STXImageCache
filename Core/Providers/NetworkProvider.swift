//
//  NetworkProvider.swift
//  STXImageCache
//
//  Created by Norbert Sroczyński on 07.02.2017.
//  Copyright © 2017 STX Next Sp. z o.o. All rights reserved.
//

import Foundation

struct NetworkProvider: Providing {
    let childProvider: Providing?
}

extension NetworkProvider {
    func get(fromURL url: URL, completion: @escaping (Data?, Error?) -> ()) {
        let request = JSONRequest(url: url)
        let _ = NetworkManager.GET(request: request).execute { result in
            switch result {
            case .error(error: let error):
                guard let child = self.childProvider else {
                    completion(nil, error)
                    return
                }
                child.get(fromURL: url, completion: completion)
            case .failed(code: let code, description: let description):
                guard let child = self.childProvider else {
                    completion(nil, self.error(withCode: code, description: description))
                    return
                }
                child.get(fromURL: url, completion: completion)
            case .success(code: _, data: let data):
                completion(data, nil)
            }
        }
    }
    
    private func error(withCode code: Int, description: String) -> NSError {
        return NSError(domain: "com.stxnext.STXImageCache.HTTPError", code: code, userInfo: [NSLocalizedDescriptionKey: description])
    }
}
