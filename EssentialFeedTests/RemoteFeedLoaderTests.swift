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
        
        XCTAssertTrue(client.requestedURLs.isEmpty)
    }

    func test_load_requestsDataFromURL() {
        let url = URL(string: "https://a-given-url.com")!
        // The url is a detail of the implementation of the remote feed loader: it should not be in the public interface
        // (because the load method can be loading from other places as well, such as cache or multiple locations)
        let (sut, client) = makeSUT(url: url)
        
        sut.load { _ in }
        
        // We need to assert that the client will request the same url as the remote feed loader will have
        XCTAssertEqual(client.requestedURLs, [url])
    }
    
    func test_loadTwice_requestsDataFromURLTwice() {
        let url = URL(string: "https://a-given-url.com")!
        let (sut, client) = makeSUT(url: url)
        
        sut.load { _ in }
        sut.load { _ in }
        
        // We will assert order, quality and count
        // We will prevent having `client.get(from:url)` called twice
        // We will also allow the `load` method to be invoked x times because we may want to make a bunch of API requests
        XCTAssertEqual(client.requestedURLs, [url, url])
    }
    
    func test_load_deliversErrorOnClientError() {
        let (sut, client) = makeSUT()
        
        var capturedError = [RemoteFeedLoader.Error]()
        sut.load {
            capturedError.append($0)
        }
        
        let clientError = NSError(domain: "Tests", code: 0)
        client.complete(with: clientError)
        
        XCTAssertEqual(capturedError, [.connectivity])
    }
    
    func test_load_deliversErrorOnNon200HTTPResponse() {
        let (sut, client) = makeSUT()
        
        let samples = [199, 201, 300, 400, 500]
        
        samples.enumerated().forEach { index, code in
            var capturedErrors = [RemoteFeedLoader.Error]()
            sut.load {
                capturedErrors.append($0)
            }
            
            client.complete(withStatusCode: code, at: index)
            
            XCTAssertEqual(capturedErrors, [.invalidData])
        }
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
        private var messages = [(url: URL, completion: (HTTPClientResult) -> Void)]()
        
        // We make a computed property
        var requestedURLs: [URL] {
            return messages.map { $0.url }
        }
        
        func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void) {
            messages.append((url, completion))
        }
        
        func complete(with error: Error, at index: Int = 0) {
            messages[index].completion(.failure(error))
        }
        
        func complete(withStatusCode code: Int, at index: Int = 0) {
            let response = HTTPURLResponse(url: requestedURLs[index],
                                           statusCode: code,
                                           httpVersion: nil,
                                           headerFields: nil)!
            messages[index].completion(.success(response))
        }
    }
}
