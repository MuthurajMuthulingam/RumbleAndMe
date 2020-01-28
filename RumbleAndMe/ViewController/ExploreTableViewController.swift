//
//  ExploreTableViewController.swift
//  RumbleAndMe
//
//  Created by Muthuraj Muthulingam on 27/01/20.
//  Copyright © 2020 Muthuraj Muthulingam. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class ExploreTableViewController: UITableViewController {
    
    private lazy var videos: [Videos] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareViews()
        fetchVideos()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func prepareViews() {
        tableView.register(UINib(nibName: String(describing: VideoListTableViewCell.self), bundle: Bundle.main), forCellReuseIdentifier: String(describing: VideoListTableViewCell.self))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    private func fetchVideos() {
        RumbleAndMeService.fetchVideos { result in
            switch result {
            case let .success(data):
                videos = data
                tableView.reloadData()
            case let .failure(error):
                debugPrint("Error : \(error)")
            }
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return videos.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return videos[section].title
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: VideoListTableViewCell.self), for: indexPath)
        if let videoCell = cell as? VideoListTableViewCell {
            videoCell.updateView(with: videos[indexPath.section].nodes)
            videoCell.delegate = self
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
}

extension ExploreTableViewController: VideoListCellEvents {
    func videoListTableViewCell(_ cell: VideoListTableViewCell, didGenerateEvent event: VideoListCellEvent) {
        switch event {
        case let .didSelectVideo(video):
            let playerViewController = VideoPlayerViewController()
            playerViewController.video = video
            navigationController?.pushViewController(playerViewController, animated: true)
        }
    }
}
