//
//  FeedImageDataStore.swift
//  EssentialFeed
//
//  Created by Leandro Fournier on 7/31/23.
//

import Foundation

public protocol FeedImageDataStore {
    typealias Result = Swift.Result<Data?, Error>

    func retrieve(dataForURL url: URL, completion: @escaping (Result) -> Void)
}
