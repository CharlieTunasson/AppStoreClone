//
//  AppsGroupCell.swift
//  AppStoreTest
//
//  Created by Charlie Tuna on 2019-04-14.
//  Copyright © 2019 Charlie Tuna. All rights reserved.
//

import UIKit

class AppsGroupCell: UICollectionViewCell {

    // MARK:- Properties
    var feed: Feed? {
        didSet {
            setData(for: feed)
        }
    }

    // MARK:- Init
    override init(frame: CGRect) {
        super.init(frame: frame)

        setUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK:- Operations
    private func setUI() {
        addSubview(titleLabel)
        addSubview(horizontalController.view)

        titleLabel.snp.makeConstraints { (make) in
            make.top.trailing.equalToSuperview()
            make.leading.equalToSuperview().inset(16)
        }

        horizontalController.view.backgroundColor = .lightGray
        horizontalController.view.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }

    private func setData(for feed: Feed?) {
        guard let feed = feed else { return }

        titleLabel.text = feed.title
        horizontalController.feedResults = feed.results
    }

    // MARK:- Components
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "App Section"
        label.font = .boldSystemFont(ofSize: 30)
        return label
    }()

    let horizontalController = AppsHorizontalController()
}
