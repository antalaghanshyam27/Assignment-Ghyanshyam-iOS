//
//  FlickrImageCollectionViewController.swift
//  Assignment-Ghyanshyam
//
//  Created by Gh@n$hyam on 07/03/25.
//

import UIKit

class FlickrImageCollectionViewController: UIViewController{
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let viewModel = FlickrViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        bindViewModel()
        
        // Fetch images from Flickr (you can modify the search text)
        viewModel.fetchImages(searchText: "nature")
    }
    
    // MARK: - Setup Collection View
    private func setupCollectionView() {
        collectionView.register(UINib(nibName: "FlickrImageCell", bundle : nil), forCellWithReuseIdentifier: "FlickrImageCell")
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        collectionView.collectionViewLayout = layout
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
    }
    
    // MARK: - Bind ViewModel
    private func bindViewModel() {
        viewModel.reloadData = { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
}

// MARK: - UICollectionView DataSource
extension FlickrImageCollectionViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FlickrImageCell", for: indexPath) as! FlickrImageCell
        
        // Fetch and set the image
        viewModel.getImage(at: indexPath.item) { image in
            cell.setImage(image)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        return CGSizeMake(collectionView.frame.width / 3 - 5, 120.0)
    }
}

// MARK: - ScrollView Delegate (for Pagination)
extension FlickrImageCollectionViewController : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        // Trigger pagination when the user scrolls near the bottom
        if offsetY > contentHeight - height - 100 {
            viewModel.loadMoreImages()
        }
    }
}
