//
//  DetailFeedViewController.swift
//  TestPexel
//
//  Created by Serhii Oleinich on 02.10.2023.
//

import UIKit

final class DetailFeedViewController: UIViewController {
    @IBOutlet private var imageView: UIImageView!
    
    var output: DetailFeedViewOutput!
    var imageLoader: ImageLoader?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        output.onViewDidLoad()
    }
}

extension DetailFeedViewController: DetailFeedViewInput {
    func didLoad(item: DetailFeedDisplayItem) {
        title = item.photographerName
        
        guard let url = URL(string: item.imageString) else { return }
        
        imageLoader?.loadImage(for: url) { image, _ in
            DispatchQueue.main.async {[weak self] in
                self?.imageView.image = image
            }
        }
    }
}

extension DetailFeedViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        imageView
    }
}
