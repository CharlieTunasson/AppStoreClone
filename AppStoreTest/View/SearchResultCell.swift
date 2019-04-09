//
//  SearchResultCell.swift
//  AppStoreTest
//
//  Created by Charlie Tuna on 2019-04-07.
//  Copyright © 2019 Charlie Tuna. All rights reserved.
//

import UIKit
import SnapKit

class SearchResultCell: UICollectionViewCell {

    var appResult: Result! {
        didSet {
            nameLabel.text = appResult.trackName
            categoryLabel.text = appResult.primaryGenreName
            ratingsLabel.text = "Rating: \(appResult.averageUserRating ?? 0)"

            let url = URL(string: appResult.artworkUrl100)
            appIconImageView.sd_setImage(with: url)

            ssFirstImageView.sd_setImage(with: URL(string: appResult.screenshotUrls[0]))

            if appResult.screenshotUrls.count > 1 {
                ssSecondImageView.sd_setImage(with: URL(string: appResult.screenshotUrls[1]))
            }

            if appResult.screenshotUrls.count > 2 {
                ssThirdImageView.sd_setImage(with: URL(string: appResult.screenshotUrls[2]))
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK:- UI
    private func setConstraints() {
        let labelsStackView = UIStackView(arrangedSubviews: [
            nameLabel, categoryLabel, ratingsLabel
            ])
        labelsStackView.axis = .vertical

        let infoTopStackView = UIStackView(arrangedSubviews: [
            appIconImageView, labelsStackView, getButton
            ])
        infoTopStackView.spacing = 10
        infoTopStackView.alignment = .center

        let ssStackView = UIStackView(arrangedSubviews: [
            ssFirstImageView, ssSecondImageView, ssThirdImageView
            ])
        ssStackView.spacing = 12
        ssStackView.distribution = .fillEqually

        let overallStackView = UIStackView(arrangedSubviews: [
            infoTopStackView, ssStackView
            ])
        overallStackView.spacing = 16
        overallStackView.axis = .vertical

        addSubview(overallStackView)

        overallStackView.snp.makeConstraints { (make) in
            make.leading.trailing.top.bottom.equalToSuperview().offset(16).inset(16)
        }
    }

    private func createScreenShotImage() -> UIImageView {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.layer.borderWidth = 0.5
        imageView.layer.borderColor = UIColor(white: 0.5, alpha: 0.5).cgColor
        imageView.contentMode = .scaleAspectFill
        return imageView
    }

    // MARK:- Components
    let appIconImageView: UIImageView = {
        let iv = UIImageView()
        iv.widthAnchor.constraint(equalToConstant: 64).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 64).isActive = true
        iv.layer.cornerRadius = 12
        iv.clipsToBounds = true
        return iv
    }()

    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "App name"
        return label
    }()
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Photos & Videos"
        return label
    }()

    let ratingsLabel: UILabel = {
        let label = UILabel()
        label.text = "9.26M"
        return label
    }()

    let getButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("GET", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        button.setTitleColor(.blue, for: .normal)
        button.widthAnchor.constraint(equalToConstant: 80).isActive = true
        button.layer.cornerRadius = 16
        return button
    }()

    lazy var ssFirstImageView = self.createScreenShotImage()
    lazy var ssSecondImageView = self.createScreenShotImage()
    lazy var ssThirdImageView = self.createScreenShotImage()
}
