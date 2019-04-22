//
//  TodayCell.swift
//  AppStoreTest
//
//  Created by Charlie Tuna on 2019-04-20.
//  Copyright © 2019 Charlie Tuna. All rights reserved.
//

import UIKit

class TodayCell: UICollectionViewCell {

    // MARK:- Init
    override init(frame: CGRect) {
        super.init(frame: frame)

        layer.cornerRadius = 10
        backgroundColor = .white
        clipsToBounds = true

        setUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    // MARK:- UI
    private func setUI() {

        let imageContainerView = UIView()
        imageContainerView.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.height.width.equalTo(200)
        }

        let stackView = UIStackView(arrangedSubviews: [
            categoryLabel, titleLabel, imageContainerView, descriptionLabel
            ])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .fill

        addSubview(stackView)

        stackView.snp.makeConstraints { (make) in
            make.leading.top.trailing.bottom.equalToSuperview().offset(24).inset(24)
        }

    }

    // MARK:- Components
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "garden")
        iv.contentMode = .scaleAspectFill
        return iv
    }()

    let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "LIFE HACK"
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Utilizing your Time"
        label.font = .boldSystemFont(ofSize: 26)
        return label
    }()

    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "All the tools and apps you need to intelligently organize your life the right way."
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 3
        return label
    }()
}
