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
    
    private lazy var video: VideoNodes? = nil
    private lazy var playerVC: AVPlayerViewController? = nil
    
    func updateView(with data: VideoNodes) {
        self.video = data
        if playerVC == nil {
            self.playerVC = AVPlayerViewController()
            self.playerVC?.view.frame = contentView.bounds
            guard let playerView = self.playerVC?.view else { return }
            contentView.addSubview(playerView)
        }
        guard let urlString = data.video.encodeUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: urlString) else { return }
        playerVC?.player = AVPlayer(url: url)
    }
    
    func playVideo() {
        playerVC?.player?.play()
    }
    
    func pauseVideo() {
        playerVC?.player?.pause()
    }
}
