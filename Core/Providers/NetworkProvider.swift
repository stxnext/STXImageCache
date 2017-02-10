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
    
    fileprivate func getFromChildProvider(fromURL url: URL, forceRefresh: Bool, completion: @escaping (Data?, NSError?) -> ()) {
        guard let childProvider = childProvider else {
            completion(nil, nil)
            return
        }
        _ = childProvider.get(fromURL: url, forceRefresh: forceRefresh, completion: completion)
    }
}

extension NetworkProvider {
    func get(fromURL url: URL, forceRefresh: Bool, completion: @escaping (Data?, NSError?) -> ()) -> URLSessionTask? {
        if forceRefresh && childProvider != nil {
            getFromChildProvider(fromURL: url, forceRefresh: forceRefresh, completion: completion)
            return nil
        }
        let request = JSONRequest(url: url)
        return NetworkManager.GET(request: request).execute { result in
            switch result {
            case .error(error: let error):
                guard self.childProvider != nil else {
                    completion(nil, error as NSError)
                    return
                }
                self.getFromChildProvider(fromURL: url, forceRefresh: forceRefresh, completion: completion)
            case .failed(code: let code, description: let description):
                guard self.childProvider != nil else {
                    completion(nil, self.error(withCode: code, description: description))
                    return
                }
                self.getFromChildProvider(fromURL: url, forceRefresh: forceRefresh, completion: completion)
            case .success(code: _, data: let data):
                completion(data, nil)
            }
        }
    }
    
    private func error(withCode code: Int, description: String) -> NSError {
        return NSError(domain: "com.stxnext.STXImageCache.HTTPError", code: code, userInfo: [NSLocalizedDescriptionKey: description])
    }
}
