//
//  FlickrImageCell.swift
//  Assignment-Ghyanshyam
//
//  Created by Gh@n$hyam on 08/03/25.
//

import UIKit

class FlickrImageCell: UICollectionViewCell {
    
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupImageView()
    }
    
    // MARK: - Prepare for reuse (reset states)
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        activityIndicator.stopAnimating()  // Ensure loader is stopped when cell is reused
        activityIndicator.isHidden = true
    }
    
    // MARK: - Setup ImageView
    private func setupImageView() {
        viewMain.layer.cornerRadius = 8.0
    }
    
    // MARK: - Set Image (Start/Stop Loader)
    func setImage(_ image: UIImage?) {
        if let image = image {
            imageView.image = image
            activityIndicator.stopAnimating()
            activityIndicator.isHidden = true
        } else {
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
        }
    }
}
