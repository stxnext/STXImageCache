//
//  StorageProvider.swift
//  STXImageCache
//
//  Created by Norbert Sroczyński on 08.02.2017.
//  Copyright © 2017 STX Next Sp. z o.o. All rights reserved.
//

import Foundation

struct StorageProvider: Providing {
    fileprivate let fileManager = FileManager()
    fileprivate var cacheDirectory: String? {
        return NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first
    }
    
    let childProvider: Providing?
    
    fileprivate func getFromChildProvider(fromURL url: URL, completion: @escaping (Data?, Error?) -> ()) {
        childProvider?.get(fromURL: url) { data, error in
            if let data = data {
                self.store(data: data, atURL: url)
            }
            completion(data, error)
        }
    }
    
    private func store(data: Data, atURL url: URL) {
        guard
            let path = pathFromURL(url: url)
        else {
            return
        }
        let fileURL = URL(fileURLWithPath: path)
        var directoryURL = fileURL
        directoryURL.deleteLastPathComponent()
        
        if !fileManager.fileExists(atPath: path) {
            try? fileManager.createDirectory(at: directoryURL, withIntermediateDirectories: true, attributes: nil)
            fileManager.createFile(atPath: path, contents: nil, attributes: nil)
        }
        let fileHandler = try? FileHandle(forWritingTo: fileURL)
        fileHandler?.write(data)
    }
    
    fileprivate func pathFromURL(url: URL) -> String? {
        guard let cacheDirectory = self.cacheDirectory else {
            return nil
        }
        var path = url.absoluteString
        if let scheme = url.scheme, path.hasPrefix(scheme) {
            path = path.substring(from: scheme.endIndex)
            let prefix = "://"
            if path.hasPrefix(prefix) {
                path = path.substring(from: prefix.endIndex)
            }
        }
        return cacheDirectory + "/" + path
    }
}

extension StorageProvider {
    func get(fromURL url: URL, completion: @escaping (Data?, Error?) -> ()) {
        guard
            let path = pathFromURL(url: url),
            fileManager.fileExists(atPath: path) == true
        else {
            getFromChildProvider(fromURL: url, completion: completion)
            return
        }
        let fileURL = URL(fileURLWithPath: path)
        do {
            let fileHandler = try FileHandle(forReadingFrom: fileURL)
            let data = fileHandler.readDataToEndOfFile()
            completion(data, nil)
        } catch {
            completion(nil, error)
        }
    }
}
