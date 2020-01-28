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
    private lazy var currentCell: VideoPlayerCell? = nil
    private lazy var isVideoPaused: Bool = false // to track one time update

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
            setVideoPlayState(true)
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
            currentCell = playerCell
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.bounds.height
    }
    
    private func getCurrentVisibleCell() -> VideoPlayerCell? {
        guard let currentCell = tableView.visibleCells.first as? VideoPlayerCell else { // since only once cell is possible to be visible
            return nil
        }
        return currentCell
    }
    
    // MARK: Scrollview delegates
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if !isVideoPaused {
           setVideoPlayState(false)
        }
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // start playing video on
        setVideoPlayState(true)
    }
    
    func setVideoPlayState(_ shouldPlay: Bool) {
        if shouldPlay {
            getCurrentVisibleCell()?.playVideo()
            isVideoPaused = false // reset state
        } else {
            getCurrentVisibleCell()?.pauseVideo()
            isVideoPaused = true
        }
    }
}
