//
//  VideoListTableViewCell.swift
//  RumbleAndMe
//
//  Created by Muthuraj Muthulingam on 27/01/20.
//  Copyright © 2020 Muthuraj Muthulingam. All rights reserved.
//

import UIKit

enum VideoListCellEvent {
    case didSelectVideo(_ videos: [VideoNodes], _ selectedIndex: Int)
}

protocol VideoListCellEvents: class {
    func videoListTableViewCell(_ cell: VideoListTableViewCell, didGenerateEvent event: VideoListCellEvent)
}


final class VideoListTableViewCell: UITableViewCell {
    
    weak var delegate: VideoListCellEvents?
    
    // MARK: - IBOutlets
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            collectionView.register(UINib(nibName: String(describing: VideoThumbnailCollectionViewCell.self), bundle: Bundle.main), forCellWithReuseIdentifier: String(describing: VideoThumbnailCollectionViewCell.self))
        }
    }
    
    private var data: [VideoNodes] = []

    func updateView(with data: [VideoNodes]) {
        collectionView.delegate = self
        collectionView.dataSource = self
        self.data = data
        collectionView.reloadData()
    }
}

extension VideoListTableViewCell: UICollectionViewDataSource,
UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width/3, height: collectionView.frame.size.height - 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: VideoThumbnailCollectionViewCell.self), for: indexPath)
        if let videoThumnailImage = cell as? VideoThumbnailCollectionViewCell {
            videoThumnailImage.updateView(with: data[indexPath.item])
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.videoListTableViewCell(self, didGenerateEvent: .didSelectVideo(data, indexPath.item))
    }
}
