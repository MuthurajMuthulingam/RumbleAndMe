//
//  VideosTableViewController.swift
//  RumbleAndMe
//
//  Created by Muthuraj Muthulingam on 28/01/20.
//  Copyright © 2020 Muthuraj Muthulingam. All rights reserved.
//

import UIKit

final class VideosTableViewController: UITableViewController {
    
    var videos: [VideoNodes] = []
    var selectedIndex: Int = 0 // default

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        tableView.isPagingEnabled = true
        prepareTable(with: VideoPlayerCell.self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // scroll to particular indexpath of selected item
        if selectedIndex > 0 {
            let indexPath = IndexPath(row: selectedIndex, section: 0)
            tableView.scrollToRow(at: indexPath, at: .middle, animated: true)
        }
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: VideoPlayerCell.self), for: indexPath)
        if let playerCell = cell as? VideoPlayerCell {
            playerCell.updateView(with: videos[indexPath.row])
            playerCell.playVideo()
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let videoCell = cell as? VideoPlayerCell {
            videoCell.playVideo()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.bounds.height
    }
}
