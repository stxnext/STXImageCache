//
//  StorageProvider.swift
//  STXImageCache
//
//  Created by Norbert Sroczyński on 08.02.2017.
//  Copyright © 2017 STX Next Sp. z o.o. All rights reserved.
//

import Foundation

struct StorageProvider: Providing {
    fileprivate let threadsManager = ThreadsManager<URL>()
    fileprivate let fileManager = FileManager()
    fileprivate var cacheDirectory: String? {
        return NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first?.appending("/STXImageCache")
    }
    
    let childProvider: Providing?
    let expirationTime: UInt
    
    init(childProvider: Providing?, expirationTime: UInt = 0) {
        self.childProvider = childProvider
        self.expirationTime = expirationTime * 24 * 3600
        clearExpiredCache()
    }
    
    fileprivate func getFromChildProvider(fromURL url: URL, forceRefresh: Bool, progress: ((Float) -> ())?, completion: @escaping (Data?, NSError?) -> ()) -> URLSessionTask? {
        guard let childProvider = childProvider else {
            self.threadsManager.unlock(forObject: url)
            completion(nil, nil)
            return nil
        }
        return childProvider.get(fromURL: url, forceRefresh: forceRefresh, progress: progress) { data, error in
            if let data = data {
                DispatchQueue.global().async {
                    self.store(data: data, atURL: url)
                    self.threadsManager.unlock(forObject: url)
                }
            } else {
                self.threadsManager.unlock(forObject: url)
            }
            completion(data, error)
        }
    }
    
    func clearCache() {
        guard
            let cacheDirectory = self.cacheDirectory
        else {
            return
        }
        try? fileManager.removeItem(atPath: cacheDirectory)
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
    
    private func clearExpiredCache() {
        guard
            self.expirationTime != 0,
            let cacheDirectory = self.cacheDirectory
        else {
            return
        }
        let resourceKeys: Set<URLResourceKey> = [.isDirectoryKey, .contentAccessDateKey, .totalFileAllocatedSizeKey]
        let expirationDate = Date(timeIntervalSinceNow: -TimeInterval(self.expirationTime))
        
        let cacheURL = URL(fileURLWithPath: cacheDirectory, isDirectory: true)
        let fileEnumerator = fileManager.enumerator(at: cacheURL, includingPropertiesForKeys: Array(resourceKeys), options: .skipsHiddenFiles, errorHandler: nil)
        while let url = fileEnumerator?.nextObject() as? URL {
            let resourceValues = try? url.resourceValues(forKeys: resourceKeys)
            if let lastAccessData = resourceValues?.contentAccessDate, lastAccessData.compare(expirationDate) == .orderedAscending {
                try? fileManager.removeItem(at: url)
            }
        }
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
        if url.isFileURL {
            return path
        }
        return cacheDirectory + "/" + path
    }
}

extension StorageProvider {
    func get(fromURL url: URL, forceRefresh: Bool, progress: ((Float) -> ())?, completion: @escaping (Data?, NSError?) -> ()) -> URLSessionTask? {
        if forceRefresh && childProvider != nil {
            return getFromChildProvider(fromURL: url, forceRefresh: forceRefresh, progress: progress, completion: completion)
        }
        threadsManager.lock(forObject: url)
        guard
            let path = pathFromURL(url: url),
            fileManager.fileExists(atPath: path) == true
        else {
            return getFromChildProvider(fromURL: url, forceRefresh: forceRefresh, progress: progress) { data, error in
                completion(data, error)
            }
        }
        let fileURL = URL(fileURLWithPath: path)
        do {
            let fileHandler = try FileHandle(forReadingFrom: fileURL)
            let data = fileHandler.readDataToEndOfFile()
            completion(data, nil)
        } catch {
            completion(nil, error as NSError)
        }
        threadsManager.unlock(forObject: url)
        return nil
    }
}
