//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Leandro Fournier on 3/21/23.
//

import Foundation

public enum LoadFeedResult {
    case success([FeedItem])
    case failure(Error)
}

protocol FeedLoader {
    
    func load(completion: @escaping (LoadFeedResult) -> Void)
}
