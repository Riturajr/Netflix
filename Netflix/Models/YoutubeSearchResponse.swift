//
//  YoutubeSearchResponse.swift
//  Netflix
//
//  Created by Rituraj on 08/08/22.
//

import Foundation

struct YoutubeSearchResponse: Codable {
    let items: [VideoElement]
}

struct VideoElement: Codable {
    let id: IdVideoElement
}
struct IdVideoElement: Codable {
    let kind: String
    let videoId: String
}
