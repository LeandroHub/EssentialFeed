//
//  FeedImageDataCache.swift
//  EssentialFeed
//
//  Created by Leandro Fournier on 8/7/23.
//

import Foundation

public protocol FeedImageDataCache {
    typealias Result = Swift.Result<Void, Error>

    func save(_ data: Data, for url: URL, completion: @escaping (Result) -> Void)
}
