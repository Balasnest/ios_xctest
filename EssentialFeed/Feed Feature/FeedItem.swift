//
//  FeedItem.swift
//  EssentialFeed
//
//  Created by BM on 04/05/24.
//

import Foundation

public struct FeedItem: Equatable {
    let uid: UUID
    let description: String?
    let location: String?
    let image: String
}
