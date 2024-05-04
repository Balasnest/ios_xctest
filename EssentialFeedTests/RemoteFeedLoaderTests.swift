//
//  RemoteFeedLoader.swift
//  EssentialFeedTests
//
//  Created by BM on 04/05/24.
//

import XCTest

class RemoteFeedLoader {
    func load() {
        HTTPClient.shared.requestURL = URL(string: "https://www.google.com")
    }
}

class HTTPClient {
    static let shared = HTTPClient()
    private init() {}
    var requestURL: URL?
}


class RemoteFeedLoaderTests: XCTestCase {
    
    func test_init_doesNotRequestDataFromURL() {
        let sut = RemoteFeedLoader()
        let client = HTTPClient.shared
        XCTAssertNil(client.requestURL)
    }
    
    func test_init_requestDataFromURL() {
        let sut = RemoteFeedLoader()
        let client = HTTPClient.shared
        sut.load()
        XCTAssertNotNil(client.requestURL)
    }
}
