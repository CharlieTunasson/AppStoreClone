//
//  SearchController.swift
//  AppStoreTest
//
//  Created by Charlie Tuna on 2019-04-06.
//  Copyright © 2019 Charlie Tuna. All rights reserved.
//

import UIKit
import SDWebImage

class SearchController: UICollectionViewController {

    private let cellId = "cell"
    private var results = [Result]()

    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .white
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func fetchITunesApps() {
        Service.shared.fetchApps { results, error in
            if let error = error {
                print(error)
                return
            }
            self.results = results
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }

    // MARK:- Lifecyle
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.register(SearchResultCell.self, forCellWithReuseIdentifier: cellId)

        fetchITunesApps()
    }

    // MARK:- CollectionView
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SearchResultCell
        cell.appResult = results[indexPath.item]
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return results.count
    }
}

extension SearchController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 350)
    }
}
