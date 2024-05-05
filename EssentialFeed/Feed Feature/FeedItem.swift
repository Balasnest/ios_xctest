//
//  FeedItem.swift
//  EssentialFeed
//
//  Created by BM on 04/05/24.
//

import Foundation

public struct FeedItem: Equatable {
    public let uid: UUID
    public let description: String?
    public let location: String?
    public let imageURL: URL
    
    public init(uid: UUID, description: String? = nil, location: String? = nil, imageURL: URL) {
        self.uid = uid
        self.description = description
        self.location = location
        self.imageURL = imageURL
    }
}
