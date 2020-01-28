//
//  VideoThumbnailCollectionViewCell.swift
//  RumbleAndMe
//
//  Created by Muthuraj Muthulingam on 27/01/20.
//  Copyright © 2020 Muthuraj Muthulingam. All rights reserved.
//

import UIKit
import AVFoundation

final class VideoThumbnailCollectionViewCell: UICollectionViewCell {

    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private weak var activityImadicatorView: UIActivityIndicatorView!
    
    private var data: VideoNodes?
    
    func updateView(with data: VideoNodes) {
        self.data = data
        imageView.image = UIImage(named: "videoPlaceholder") // placeholder image
        showActivityIndicatorView(true)
        data.thumbnailImage { [weak self] image, urlString in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.showActivityIndicatorView(false)
                guard data.video.encodeUrl == urlString else { return }
                self.imageView.image = image
            }
        }
    }
    
    private func showActivityIndicatorView(_ shouldShow: Bool) {
        activityImadicatorView.isHidden = !shouldShow
        if !activityImadicatorView.isAnimating && shouldShow {
            activityImadicatorView.startAnimating()
        } else {
            activityImadicatorView.stopAnimating()
        }
    }
}

typealias ImageCompletion = (_ image: UIImage?, _ urlString: String) -> Void

extension VideoNodes {
    func thumbnailImage(_ completion: @escaping ImageCompletion) {
        /*guard let url = URL(fileURLWithPath: video.encodeUrl) else { // URL(string: video.encodeUrl)
            completion(nil, "")
            return
        }*/
        let url: URL = URL(fileURLWithPath: video.encodeUrl)
        guard let image = DataCache.shared.retrive(imageFor: url.absoluteString) else {
            url.thumnailImage { image, urlString in
                if let unwrappedImage = image {
                    DataCache.shared.store(image: unwrappedImage, for: urlString)
                }
                completion(image, urlString)
            }
            return
        }
        completion(image, url.absoluteString)
    }
}

extension URL {
    func thumnailImage(_ completion: @escaping ImageCompletion) {
        DispatchQueue.global().async {
            let asset: AVAsset = AVAsset(url: self)
            let imageGenerator: AVAssetImageGenerator = AVAssetImageGenerator(asset: asset)
            do {
                let image = try imageGenerator.copyCGImage(at: CMTime(seconds: 1, preferredTimescale: 60), actualTime: nil)
                completion(UIImage(cgImage: image), self.absoluteString)
            } catch let error {
                debugPrint("Error : \(error)")
                completion(nil, self.absoluteString)
            }
        }
    }
}
