//
//  FeedImageViewModel.swift
//  EssentialFeediOS
//
//  Created by Leandro Fournier on 7/13/23.
//

struct FeedImageViewModel<Image> {
    let description: String?
    let location: String?
    let image: Image?
    let isLoading: Bool
    let shouldRetry: Bool

    var hasLocation: Bool {
        return location != nil
    }
}
