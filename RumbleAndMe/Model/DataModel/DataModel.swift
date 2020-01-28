//
//  DataModel.swift
//  RumbleAndMe
//
//  Created by Muthuraj Muthulingam on 27/01/20.
//  Copyright © 2020 Muthuraj Muthulingam. All rights reserved.
//

import Foundation

struct Videos: Decodable {
    let title: String
    let nodes: [VideoNodes]
}

struct VideoNodes: Decodable {
    let video: Video
}

struct Video: Decodable {
    let encodeUrl: String
}

enum APIResult<T: Decodable> {
    case success(_ data: T)
    case failure(_ error: APIError)
}

struct APIError: Error {
    var message: String
}

typealias VideosCompletion = ((APIResult<[Videos]>) -> Void)

// MARK: - Helper class
final class RumbleAndMeService {
    static func fetchVideos(_ completion: VideosCompletion) {
        guard let url = Bundle.main.url(forResource: "assignment", withExtension: "json") else {
            completion(.failure(APIError(message: "Failed to create URL")))
            return
        }
        do {
            let data = try Data(contentsOf: url, options: .uncached)
            let videos: [Videos] = try JSONDecoder().decode([Videos].self, from: data)
            completion(.success(videos))
        } catch let error {
            completion(.failure(APIError(message: error.localizedDescription)))
        }
    }
}
