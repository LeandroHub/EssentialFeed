//
//  FeedErrorViewModel.swift
//  EssentialFeed
//
//  Created by Leandro Fournier on 7/27/23.
//

public struct FeedErrorViewModel {
    public let message: String?

    static var noError: FeedErrorViewModel {
        return FeedErrorViewModel(message: nil)
    }

    static func error(message: String) -> FeedErrorViewModel {
        return FeedErrorViewModel(message: message)
    }
}

