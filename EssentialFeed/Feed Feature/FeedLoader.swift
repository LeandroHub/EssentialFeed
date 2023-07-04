//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Leandro Fournier on 3/21/23.
//

import Foundation

public protocol FeedLoader {
    typealias Result = Swift.Result<[FeedImage], Error>
    
    func load(completion: @escaping (Result) -> Void)
}
