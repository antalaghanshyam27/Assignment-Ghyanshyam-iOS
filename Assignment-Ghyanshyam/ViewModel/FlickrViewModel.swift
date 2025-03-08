//
//  FlickrViewModel.swift
//  Assignment-Ghyanshyam
//
//  Created by Gh@n$hyam on 08/03/25.
//

import Foundation
import UIKit

// MARK: - ViewModel for Pexels API with Pagination
class FlickrViewModel {
    
    private var images: [PexelsImage] = []
    private let imageCache = NSCache<NSURL, UIImage>()
    
    var reloadData: (() -> Void)?
    
    private let apiKey = "Om7I3Dj8pyBKNw4kWMcoqKuGvqfqjc1nZmkIhQ7SPrihhFUGd9BLhQ9g"
    private let pexelsAPIURL = "https://api.pexels.com/v1/search?query=YOUR_SEARCH_TERM&per_page=20&page=YOUR_PAGE"
    
    // Pagination variables
    private var currentPage = 1
    private var totalResults = 0
    private var isFetching = false
    private var searchText = ""
    
    // MARK: - Fetch Images from Pexels API with Pagination
    func fetchImages(searchText: String, page: Int = 1) {
        guard !isFetching else { return }
        
        self.isFetching = true
        self.searchText = searchText
        
        let urlString = pexelsAPIURL
            .replacingOccurrences(of: "YOUR_SEARCH_TERM", with: searchText)
            .replacingOccurrences(of: "YOUR_PAGE", with: String(page))
        
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url)
        request.addValue(apiKey, forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            if let error = error {
                print("Error fetching images: \(error.localizedDescription)")
                self?.isFetching = false
                return
            }
            
            guard let data = data else { return }
            
            do {
                let decodedData = try JSONDecoder().decode(PexelsResponse.self, from: data)
                
                // Update the total number of results
                self?.totalResults = decodedData.total_results
                
                // Append new images to the existing ones
                if page == 1 {
                    self?.images = decodedData.photos
                } else {
                    self?.images.append(contentsOf: decodedData.photos)
                }
                
                DispatchQueue.main.async {
                    self?.reloadData?()
                }
                
            } catch {
                print("Error decoding data: \(error.localizedDescription)")
            }
            self?.isFetching = false
        }.resume()
    }
    
    // MARK: - Image Caching and Fetching
    func getImage(at index: Int, completion: @escaping (UIImage?) -> Void) {
        let photo = images[index]
        let imageURL = NSURL(string: photo.src.medium)!
        
        // Check the cache for the image
        if let cachedImage = imageCache.object(forKey: imageURL) {
            completion(cachedImage)
            return
        }
        
        // Download image if not cached
        URLSession.shared.dataTask(with: imageURL as URL) { [weak self] data, response, error in
            guard let data = data, let image = UIImage(data: data), error == nil else {
                completion(nil)
                return
            }
            
            // Cache the downloaded image
            self?.imageCache.setObject(image, forKey: imageURL)
            
            DispatchQueue.main.async {
                completion(image)
            }
        }.resume()
    }
    
    // MARK: - Pagination Logic
    func loadMoreImages() {
        let totalPages = totalResults / 20
        if currentPage < totalPages {
            currentPage += 1
            fetchImages(searchText: searchText, page: currentPage)
        }
    }
    
    // Get the number of items (photos)
    func numberOfItems() -> Int {
        return images.count
    }
}
