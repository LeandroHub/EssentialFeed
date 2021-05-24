//
//  RemoteFeedLoaderTests.swift
//  EssentialFeedTests
//
//  Created by Leandro Fournier on 4/28/21.
//

import XCTest
import EssentialFeed

class RemoteFeedLoaderTests: XCTestCase {

    func test_init_doesNotRequestDataFromURL() {
        let (_, client) = makeSUT()
        
        XCTAssertNil(client.requestedURL)
    }

    func test_load_requestsDataFromURL() {
        let url = URL(string: "https://a-given-url.com")!
        // The url is a detail of the implementation of the remote feed loader: it should not be in the public interface
        // (because the load method can be loading from other places as well, such as cache or multiple locations)
        let (sut, client) = makeSUT(url: url)
        
        sut.load()
        
        // We need to assert that the client will request the same url as the remote feed loader will have
        XCTAssertEqual(client.requestedURL, url)
    }
    
    // MARK: - Helpers
    
    // Let's create a factory method to avoid duplications
    // We return a tuple because we need to assert the client
    private func makeSUT(url: URL = URL(string: "http://a-url.com")!) -> (sut: RemoteFeedLoader, client: HTTPClientSpy) {
        let client = HTTPClientSpy()
        let sut = RemoteFeedLoader(url: url, client: client)
        return (sut, client)
    }
    
    // We move the HTTPClientSpy inside the tests scope: it's not going to be production code
    private class HTTPClientSpy: HTTPClient {
        var requestedURL: URL?
        
        func get(from url: URL) {
            requestedURL = url
        }
    }
}
