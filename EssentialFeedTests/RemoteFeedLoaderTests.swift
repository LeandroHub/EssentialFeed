//
//  RemoteFeedLoaderTests.swift
//  EssentialFeedTests
//
//  Created by Leandro Fournier on 4/28/21.
//

import XCTest

class RemoteFeedLoader {
    let client: HTTPClient
    let url: URL
    
    init(url: URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }
    
    func load() {
        client.get(from: url)
    }
}


// HTTP is the collaborator (e.g. AFNetworking, URLSession, etc)
protocol HTTPClient {
    func get(from url: URL)
}


class HTTPClientSpy: HTTPClient {
    var requestedURL: URL?
    
    func get(from url: URL) {
        requestedURL = url
    }
}


class RemoteFeedLoaderTests: XCTestCase {

    func test_init_doesNotRequestDataFromURL() {
        let url = URL(string: "http://a-url.com")!
        let client = HTTPClientSpy()
        _ = RemoteFeedLoader(url: url, client: client)
        
        XCTAssertNil(client.requestedURL)
    }

    func test_load_requestDataFromURL() {
        let url = URL(string: "https://a-given-url.com")!
        let client = HTTPClientSpy()
        // The url is a detail of the implementation of the remote feed loader: it should not be in the public interface
        // (because the load method can be loading from other places as well, such as cache or multiple locations)
        let sut = RemoteFeedLoader(url: url, client: client)
        
        sut.load()
        
        // We need to assert that the client will request the same url as the remote feed loader will have
        XCTAssertEqual(client.requestedURL, url)
    }
}
