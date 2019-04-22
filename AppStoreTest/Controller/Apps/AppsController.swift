//
//  AppsController.swift
//  AppStoreTest
//
//  Created by Charlie Tuna on 2019-04-13.
//  Copyright © 2019 Charlie Tuna. All rights reserved.
//

import UIKit


class AppsController: UICollectionViewController {

    // MARK:- Properties
    let cellIdentifier = "cellIdentifier"
    let headerIdentifier = "headerIdentifier"
    var groups: [AppGroup]?
    var socialApps: [SocialApp]?
    let refreshController = UIRefreshControl()

    // MARK:- Init
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        refreshController.addTarget(self, action: #selector(handleRefreshAction), for: .valueChanged)

        collectionView.refreshControl = refreshController
        collectionView.backgroundColor = .white
        collectionView.register(AppsHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier)
        collectionView.register(AppsGroupCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.showsVerticalScrollIndicator = false

        view.addSubview(activityIndicator)

        activityIndicator.snp.makeConstraints { (make) in
            make.leading.top.trailing.bottom.equalToSuperview()
        }

        activityIndicator.startAnimating()
        fetchData()
    }

    // MARK:- Operations
    private func fetchData() {
        let dispatchGroup = DispatchGroup()

        dispatchGroup.enter()
        dispatchGroup.enter()

        Service.shared.fetchAppsWeLove(for: [
            URL(string: "https://rss.itunes.apple.com/api/v1/se/ios-apps/new-apps-we-love/all/50/explicit.json"),
            URL(string: "https://rss.itunes.apple.com/api/v1/se/ios-apps/new-games-we-love/all/50/explicit.json"),
            URL(string: "https://rss.itunes.apple.com/api/v1/se/ios-apps/top-free/all/50/explicit.json")
        ]) { (groups, errors) in

            for errorModel in errors {
                print("#Error", errorModel.error.localizedDescription, errorModel.url ?? "")
            }

            self.groups = groups
            dispatchGroup.leave()
        }


        Service.shared.fetchSocialApps { (apps, error) in
            if let error = error {
                print(error)
                dispatchGroup.leave()
                return
            }

            self.socialApps = apps
            dispatchGroup.leave()
        }

        dispatchGroup.notify(queue: .main) { [weak self] in
            self?.collectionView.reloadData()
            self?.activityIndicator.stopAnimating()
            self?.refreshController.endRefreshing()
        }
    }

    // MARK:- CollectionView
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath) as! AppsHeader
        if let apps = socialApps {
            header.appsHeaderHorizontalController.apps = apps
        }
        return header
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 300)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! AppsGroupCell
        cell.feed = groups?[indexPath.item].feed
        return cell
    }

    // MARK:- Objc
    @objc func handleRefreshAction() {
        fetchData()
    }

    // MARK:- Components
    let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .whiteLarge)
        indicator.color = .black
        indicator.hidesWhenStopped = true
        return indicator
    }()
}

extension AppsController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: view.frame.width, height: 300)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 16, left: 0, bottom: 0, right: 0)
    }
}
