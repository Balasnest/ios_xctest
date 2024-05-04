//
//  RemoteFeedLoader.swift
//  EssentialFeedTests
//
//  Created by BM on 04/05/24.
//

import XCTest

class RemoteFeedLoader {
    let client: HTTPClient
    let url: URL
    
    init(url: URL, client: HTTPClient) {
        self.client = client
        self.url = url
    }
    
    func load() {
        client.get(from: url)
    }
}

protocol HTTPClient {
    func get(from url: URL)
}


 
class RemoteFeedLoaderTests: XCTestCase {
    
    func test_init_doesNotRequestDataFromURL() {
        let (_, client) = makeSUT()
        XCTAssertNil(client.requestURL)
    }
    
    func test_init_requestDataFromURL() {
        let url = URL(string: "http://www.google.com")
        let (sut, client) = makeSUT (url: url!)

        sut.load()
        XCTAssertNotNil(client.requestURL)
    }
    
    // MARK: - Helpers
    
    private func makeSUT(url: URL = URL(string: "http://www.google.com")!) -> (sut: RemoteFeedLoader, client: HTTPClientSpy) {
        let client = HTTPClientSpy()
        let sut = RemoteFeedLoader(url: url, client: client)
        return (sut, client)
    }
    
    class HTTPClientSpy: HTTPClient {
        var requestURL: URL?
        
        func get(from url: URL) {
            requestURL = url
        }
    }
}
