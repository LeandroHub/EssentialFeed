//
//  SharedTestHelpers.swift
//  EssentialFeedTests
//
//  Created by Leandro Fournier on 6/8/23.
//

import Foundation

func anyNSError() -> NSError {
    return NSError(domain: "any error", code: 0)
}

func anyURL() -> URL {
    return URL(string: "http://any-url.com")!
}
