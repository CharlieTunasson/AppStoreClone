//
//  AppsHeaderCell.swift
//  AppStoreTest
//
//  Created by Charlie Tuna on 2019-04-19.
//  Copyright © 2019 Charlie Tuna. All rights reserved.
//

import UIKit

class AppsHeaderCell: UICollectionViewCell {

    // MARK:- Properties
    var app: SocialApp? {
        didSet {
            setData(for: app)
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
        let stackView = UIStackView(arrangedSubviews: [
            companyNameLabel, descriptionLabel, imageView
            ])

        addSubview(stackView)

        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalToSuperview().offset(16)
        }
    }

    private func setData(for app: SocialApp?) {
        guard let app = app else { return }

        companyNameLabel.text = app.name
        descriptionLabel.text = app.tagline
        imageView.sd_setImage(with: URL(string: app.imageUrl), completed: nil)
    }

    // MARK:- Components
    let companyNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Company Name"
        label.font = .boldSystemFont(ofSize: 12)
        label.textColor = .blue
        return label
    }()

    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Keeping up with friends is faster than ever"
        label.font = .boldSystemFont(ofSize: 24)
        label.numberOfLines = 0
        return label
    }()

    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 8
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = .lightGray
        return iv
    }()
}
