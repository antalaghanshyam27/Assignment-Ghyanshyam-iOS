# Assignment-Ghyanshyam-iOS
Assignment-Ghyanshyam iOS Developer

Pexels API Image Viewer (MVVM Architecture)

This project demonstrates how to fetch and display images from the Pexels API using Swift and the MVVM architecture. The images are asynchronously fetched and cached, and pagination is implemented for infinite scrolling.

Features
    •    MVVM Architecture: Separation of concerns using Model-View-ViewModel (MVVM) pattern.
    •    Asynchronous Image Fetching: Images are fetched asynchronously from the Pexels API.
    •    Image Caching: Images are cached to improve performance and reduce network calls.
    •    Pagination: Infinite scrolling with pagination is implemented for fetching images in batches.
    •    Activity Indicator: Each image cell displays a loading spinner while the image is being fetched.

Project Structure

This project uses the MVVM architecture, which separates the responsibilities into three main components:
    •    Model: Represents the data (e.g., PexelsImage, PexelsResponse).
    •    ViewModel: Handles the logic for fetching images, managing pagination, and caching.
    •    View (Controller): Handles the UI and binds to the ViewModel.

Key Files
    •    PexelsImage.swift: Defines the PexelsImage model and response structure.
    •    PexelsViewModel.swift: Handles the API requests, caching, and pagination.
    •    PexelsImageCollectionViewController.swift: Displays the images in a UICollectionView and handles user interaction.
    •    FlickrImageCell.swift: Custom cell with a loading indicator to display images.

How It Works
    1.    PexelsViewModel: Fetches images from the Pexels API asynchronously using URLSession. The fetched images are decoded into models and passed to the ViewController for display. Images are also cached using NSCache to avoid redundant network calls.
    2.    Pagination: The ViewModel uses the per_page and page parameters in the API request to load more images as the user scrolls. When the user scrolls near the bottom, the loadMoreImages() function is triggered, which fetches the next batch of images.
    3.    CollectionView: The UICollectionView in PexelsImageCollectionViewController is responsible for displaying the images. It uses a custom cell that shows an activity indicator while images are being fetched.
    4.    Image Caching: Images are cached using NSCache to ensure that images that have already been fetched don’t require another network call when they are displayed again.
