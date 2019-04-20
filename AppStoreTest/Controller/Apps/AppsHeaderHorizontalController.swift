//
//  AppsHeaderHorizontalController.swift
//  AppStoreTest
//
//  Created by Charlie Tuna on 2019-04-19.
//  Copyright © 2019 Charlie Tuna. All rights reserved.
//

import UIKit

class AppsHeaderHorizontalController: HorizontalSnappingCVC {

    // MARK:- Properties
    let cellIdentifier = "cellIdentifier"
    var apps = [SocialApp]() {
        didSet {
            collectionView.reloadData()
        }
    }

    // MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.register(AppsHeaderCell.self, forCellWithReuseIdentifier: cellIdentifier)
    }

    // MARK:- CollectionView
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return apps.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! AppsHeaderCell
        cell.app = apps[indexPath.item]
        return cell
    }
}

extension AppsHeaderHorizontalController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width*0.9, height: view.frame.height)
    }
}
