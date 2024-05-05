//
//  FeedItemMapper.swift
//  EssentialFeed
//
//  Created by BM on 05/05/24.
//

import Foundation

internal class FeedItemMapper {
    private struct Root: Decodable {
        let items: [item]
        
        var feed: [FeedItem] {
            return items.map { $0.item }
        }
    }

    private struct item: Decodable {
        let id: UUID
        let description: String?
        let location: String?
        let image: URL
        
        var item: FeedItem {
            return FeedItem(uid: id, description: description, location: location, imageURL: image)
        }
    }
    
    private static var OK_200: Int { return 200 }

    internal static func map(_ data: Data, _ response: HTTPURLResponse) -> RemoteFeedLoader.Result {
        guard response.statusCode == OK_200,
                let root = try? JSONDecoder().decode(Root.self, from: data) else {
            return .failure(.invalidData)
        }
        
        let items = root.feed
        return .success(items)
    }
}
