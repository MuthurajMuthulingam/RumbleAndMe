//
//  VideoPlayerCell.swift
//  RumbleAndMe
//
//  Created by Muthuraj Muthulingam on 28/01/20.
//  Copyright © 2020 Muthuraj Muthulingam. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

final class VideoPlayerCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var thumbnailImageView: UIImageView!
    
    private lazy var video: VideoNodes? = nil
    private lazy var playerVC: AVPlayerViewController? = nil

    func updateView(with data: VideoNodes) {
        self.video = data
        data.thumbnailImage { [weak self] image, urlString in
            guard let self = self, urlString == self.video?.video.encodeUrl else { return }
            self.thumbnailImageView.image = image
        }
        if playerVC == nil {
            self.playerVC = AVPlayerViewController()
            self.playerVC?.view.frame = contentView.bounds
            guard let playerView = self.playerVC?.view else { return }
            contentView.addSubview(playerView)
        }
        guard let urlString = video?.video.encodeUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: urlString) else { return }
        playerVC?.player = AVPlayer(url: url)
        playVideo()
    }
    
    func playVideo() {
        playerVC?.player?.play()
    }
    
    func pauseVideo() {
        playerVC?.player?.pause()
    }
}
