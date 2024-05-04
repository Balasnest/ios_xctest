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

class HTTPClientSpy: HTTPClient {
    var requestURL: URL?
    
    func get(from url: URL) {
        requestURL = url
    }
}
 
class RemoteFeedLoaderTests: XCTestCase {
    
    func test_init_doesNotRequestDataFromURL() {
        let client = HTTPClientSpy()
        let url = URL(string: "http://www.google.com")
        let sut = RemoteFeedLoader(url: url!, client: client)

        XCTAssertNil(client.requestURL)
    }
    
    func test_init_requestDataFromURL() {
        let client = HTTPClientSpy()
        let url = URL(string: "http://www.google.com")
        let sut = RemoteFeedLoader(url: url!, client: client)

        sut.load()
        XCTAssertNotNil(client.requestURL)
    }
}
