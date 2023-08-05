//
//  SharedTestHelpers.swift
//  EssentialAppTests
//
//  Created by Leandro Fournier on 8/5/23.
//

import Foundation

func anyData() -> Data {
    return Data("any data".utf8)
}

func anyURL() -> URL {
    return URL(string: "http://a-url.com")!
}

func anyNSError() -> NSError {
    return NSError(domain: "any error", code: 0)
}
