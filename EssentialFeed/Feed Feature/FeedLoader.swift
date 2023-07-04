//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Leandro Fournier on 3/21/23.
//

import Foundation

public typealias LoadFeedResult = Result<[FeedImage], Error>

public protocol FeedLoader {
    
    func load(completion: @escaping (LoadFeedResult) -> Void)
}
