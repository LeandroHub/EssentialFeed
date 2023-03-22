//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Leandro Fournier on 3/21/23.
//

import Foundation

enum LoadFeedResult {
    case success([FeedItem])
    case error(Error)
}

protocol FeedLoader {
    func load(completion: @escaping (LoadFeedResult) -> Void)
}
