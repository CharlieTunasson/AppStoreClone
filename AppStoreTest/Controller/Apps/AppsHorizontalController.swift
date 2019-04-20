//
//  AppsHorizontalController.swift
//  AppStoreTest
//
//  Created by Charlie Tuna on 2019-04-19.
//  Copyright © 2019 Charlie Tuna. All rights reserved.
//

import UIKit

class AppsHorizontalController: HorizontalSnappingCVC {

    // MARK:- Properties
    private let cellIdentifier = "cellIdentifier"
    var feedResults = [FeedResult]() {
        didSet {
            collectionView.reloadData()
        }
    }

    // MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.register(AppsRowCell.self, forCellWithReuseIdentifier: cellIdentifier)
    }

    // MARK:- CollectionView
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return feedResults.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! AppsRowCell
        cell.feedResult = feedResults[indexPath.row]
        return cell
    }
}

extension AppsHorizontalController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width*0.90, height: view.frame.height/3 - 16)
    }
}
