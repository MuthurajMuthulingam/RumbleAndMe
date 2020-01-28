//
//  VideoPlayerViewController.swift
//  RumbleAndMe
//
//  Created by Muthuraj Muthulingam on 28/01/20.
//  Copyright © 2020 Muthuraj Muthulingam. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class VideoPlayerViewController: AVPlayerViewController {

    var video: VideoNodes?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        
        prepareViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    
    private func prepareViews() {
        guard let urlString = video?.video.encodeUrl,
            let url = URL(string: urlString) else { return }
        let player = AVPlayer(url: url)
        self.player = player
        self.player?.play()
    }
}
