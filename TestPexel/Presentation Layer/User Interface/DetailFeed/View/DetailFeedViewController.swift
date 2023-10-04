//
//  DetailFeedViewController.swift
//  TestPexel
//
//  Created by Serhii Oleinich on 02.10.2023.
//

import UIKit

final class DetailFeedViewController: UIViewController {
    var output: DetailFeedViewOutput!
    var imageLoader: ImageLoader?
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        
        return activityIndicator
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.delegate = self
        scrollView.backgroundColor = .systemBackground
        scrollView.maximumZoomScale = Constants.maxZoom
        
        return scrollView
    }()
    
    override func loadView() {
        setup(view: scrollView)
        
        self.view = scrollView
        
        setupConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        output.onViewDidLoad()
    }
}

// MARK: - DetailFeedViewInput

extension DetailFeedViewController: DetailFeedViewInput {
    func didLoad(item: DetailFeedDisplayItem) {
        title = item.photographerName
        
        asynLoadImage(from: item.imageUrl)
    }
}

// MARK: - UIScrollViewDelegate

extension DetailFeedViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? { imageView }
}

// MARK: - Private

private extension DetailFeedViewController {
    func setup(view: UIView) {
        view.addSubview(activityIndicator)
        view.addSubview(imageView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            imageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor)
        ])
    }
    
    func asynLoadImage(from url: URL?) {
        guard let url = url else {
            activityIndicator.stopAnimating()
            imageView.image = nil
            return
        }
        
        imageLoader?.loadImage(for: url) { image, _ in
            DispatchQueue.main.async {[weak self] in
                guard let self = self else { return }
                
                if let imageWidth = image?.size.width, imageWidth.isZero == false {
                    let scale = self.scrollView.bounds.width / imageWidth
                    self.scrollView.minimumZoomScale = scale
                    self.scrollView.zoomScale = scale
                }
                
                UIView.transition(
                    with: self.imageView,
                    duration: UINavigationController.hideShowBarDuration,
                    options: .transitionCrossDissolve,
                    animations: { self.imageView.image = image },
                    completion: { _ in self.activityIndicator.stopAnimating() })
            }
        }
    }
}

// MARK: - Constants

private extension DetailFeedViewController {
    enum Constants {
        static let maxZoom = 8.0
    }
}
