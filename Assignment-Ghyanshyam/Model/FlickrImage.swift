//
//  PexelsImage.swift
//  Assignment-Ghyanshyam
//
//  Created by Gh@n$hyam on 08/03/25.
//

import Foundation

// MARK: - Pexels Response
struct PexelsResponse: Codable {
    let photos: [PexelsImage]
    let total_results: Int
    let page: Int
    let per_page: Int
    let next_page: String?
}

// MARK: - Pexels Image Model
struct PexelsImage: Codable {
    let id: Int
    let url: String
    let photographer: String
    let src: ImageSource
}

// MARK: - Image Source URLs
struct ImageSource: Codable {
    let original: String
    let medium: String
}
