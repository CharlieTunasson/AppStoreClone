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

    // MARK:- Properties
    private let cellId = "cell"
    private var timer: Timer?
    private var results = [Result]()
    private var searchController = UISearchController(searchResultsController: nil)

    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .white
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK:- Lifecyle
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.register(SearchResultCell.self, forCellWithReuseIdentifier: cellId)

        collectionView.backgroundView = backgroundLabel
        setSearchBar()
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

    // MARK:- Operations
    private func setSearchBar() {
        definesPresentationContext = false
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
    }

    // MARK:- Components
    let backgroundLabel: UILabel = {
        let label = UILabel()
        label.text = "Please enter search term above..."
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
}

// MARK:- SearchBar
extension SearchController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        // Delay before you make the next API call
        timer?.invalidate()

        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            Service.shared.fetchApps(for: searchText) { results, error in
                if let error = error {
                    print(error)
                    return
                }
                self.results = results
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        })
    }
}

// MARK:- CollectionViewDelegateFlowLayout
extension SearchController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 350)
    }
}
