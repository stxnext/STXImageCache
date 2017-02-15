//
//  ImageDownloader.swift
//  STXImageCache
//
//  Created by Norbert Sroczyński on 10.02.2017.
//  Copyright © 2017 STX Next Sp. z o.o. All rights reserved.
//

import Foundation

typealias ImageDownloaderProgress = (Float) -> ()
typealias ImageDownloaderCompletion = (Data?, NSError?) -> ()

final class ImageDownloader: NSObject {
    fileprivate var completionBlocks: [Int: ImageDownloaderCompletion] = [:]
    fileprivate var progressBlocks: [Int: ImageDownloaderProgress] = [:]
    private var urlSession: URLSession!
    
    init(configuration: URLSessionConfiguration = URLSessionConfiguration.background(withIdentifier: "backgroundSession")) {
        super.init()
        urlSession = URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
    }
    
    deinit {
        urlSession.invalidateAndCancel()
    }
    
    func download(fromURL url: URL, progress: ImageDownloaderProgress?, completion: @escaping ImageDownloaderCompletion) -> URLSessionDownloadTask {
        let urlTask = urlSession.downloadTask(with: url)
        progressBlocks[urlTask.taskIdentifier] = progress
        completionBlocks[urlTask.taskIdentifier] = completion
        urlTask.resume()
        return urlTask
    }
}

extension ImageDownloader: URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        guard let completion = completionBlocks[downloadTask.taskIdentifier] else {
            return
        }
        do {
            let fileHandler = try FileHandle(forReadingFrom: location)
            let data = fileHandler.readDataToEndOfFile()
            completion(data, nil)
        } catch {
            completion(nil, error as NSError)
        }
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        guard
            let progress = progressBlocks[downloadTask.taskIdentifier],
            totalBytesExpectedToWrite != NSURLSessionTransferSizeUnknown
        else {
            return
        }
        progress(Float(totalBytesWritten)/Float(totalBytesExpectedToWrite))
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        guard
            challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust,
            let trust = challenge.protectionSpace.serverTrust
        else {
            completionHandler(.performDefaultHandling, nil)
            return
        }
        let credential = URLCredential(trust: trust)
        completionHandler(.useCredential, credential)
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        defer {
            completionBlocks[task.taskIdentifier] = nil
            progressBlocks[task.taskIdentifier] = nil
        }
        guard let error = error else {
            return
        }
        guard let completion = completionBlocks[task.taskIdentifier] else {
            return
        }
        let cocoaError = error as NSError
        if cocoaError.code == -999 {
            completion(nil, nil)
            return
        }
        completion(nil, cocoaError)
    }
}
