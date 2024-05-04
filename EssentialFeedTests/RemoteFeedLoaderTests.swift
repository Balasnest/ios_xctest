//
//  RemoteFeedLoader.swift
//  EssentialFeedTests
//
//  Created by BM on 04/05/24.
//

import XCTest
import EssentialFeed
 
class RemoteFeedLoaderTests: XCTestCase {
    
//    func test_init_doesNotRequestDataFromURL() {
//        let (_, client) = makeSUT()
//        XCTAssertTrue(client.requestedURLs.isEmpty)
//    }
//    
//    func test_init_requestDataFromURL() {
//        let url = URL(string: "http://www.google.com")
//        let (sut, client) = makeSUT (url: url!)
//
//        sut.load()
//        XCTAssertEqual(client.requestedURLs, [url])
//    }
    
//    func test_init_requestDataFromURL_twice() {
//        let url = URL(string: "http://www.google.com")
//        let (sut, client) = makeSUT (url: url!)
//
//        sut.load()
//        sut.load()
//        XCTAssertEqual(client.requestedURLs, [url, url])
//    }
    
    func test_load_deliversErrorOnClientError() {
        // Arrange:
        let (sut, client) = makeSUT()
        
        // Act:
        var capturedErrors = [RemoteFeedLoader.Error]()
        sut.load { capturedErrors.append($0) }
        
        let clientError = NSError(domain: "Test", code: 0)
        client.completions[0](clientError)
        
        // Assert
        XCTAssertEqual(capturedErrors, [.connectivity])
        
    }
    
    // MARK: - Helpers
    
    private func makeSUT(url: URL = URL(string: "http://www.google.com")!) -> (sut: RemoteFeedLoader, client: HTTPClientSpy) {
        let client = HTTPClientSpy()
        let sut = RemoteFeedLoader(url: url, client: client)
        return (sut, client)
    }
    
    class HTTPClientSpy: HTTPClient {
        var requestedURLs = [URL]()
        var completions = [(Error) -> Void]()
        
        func get(from url: URL, completion: @escaping (Error) -> Void) {
            completions.append(completion)
            requestedURLs.append(url)
        }
    }
}
