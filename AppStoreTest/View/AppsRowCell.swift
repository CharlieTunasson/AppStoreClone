//
//  AppRowCell.swift
//  AppStoreTest
//
//  Created by Charlie Tuna on 2019-04-19.
//  Copyright © 2019 Charlie Tuna. All rights reserved.
//

import UIKit
import SDWebImage

class AppsRowCell: UICollectionViewCell {

    // MARK:- Properties
    var feedResult: FeedResult? {
        didSet {
            setData(for: feedResult)
        }
    }

    // MARK:- Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white

        setUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK:- UI
    private func setUI() {

        let titlesStackView = UIStackView(arrangedSubviews: [
            nameLabel, companyLabel
            ])
        titlesStackView.axis = .vertical

        let mainStackView = UIStackView(arrangedSubviews: [
            imageView, titlesStackView, getButton
            ])

        addSubview(mainStackView)

        getButton.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        getButton.layer.cornerRadius = 16
        getButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        getButton.snp.makeConstraints { (make) in
            make.height.equalTo(32)
            make.width.equalTo(80)
        }

        imageView.snp.makeConstraints { (make) in
            make.width.equalTo(64)
            make.height.equalTo(64)
        }

        mainStackView.alignment = .center
        mainStackView.spacing = 16
        mainStackView.snp.makeConstraints { (make) in
            make.leading.top.trailing.bottom.equalToSuperview()
        }
    }

    private func setData(for feedResult: FeedResult?) {
        guard let result = feedResult else { return }

        nameLabel.text = result.artistName
        companyLabel.text = result.name
        imageView.sd_setImage(with: URL(string: result.artworkUrl100), completed: nil)
    }

    // MARK:- Components
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 8
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = .lightGray
        return iv
    }()

    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "App Name"
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()

    let companyLabel: UILabel = {
        let label = UILabel()
        label.text = "Company Name"
        label.font = .boldSystemFont(ofSize: 13)
        return label
    }()

    let getButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("GET", for: .normal)
        return button
    }()
}
