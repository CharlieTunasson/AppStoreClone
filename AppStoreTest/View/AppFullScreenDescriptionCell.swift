//
//  AppFullScreenDescriptionCell.swift
//  AppStoreTest
//
//  Created by Charlie Tuna on 2019-04-21.
//  Copyright © 2019 Charlie Tuna. All rights reserved.
//

import UIKit

class AppFullScreenDescriptionCell: UITableViewCell {

    // MARK:- Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    // MARK:- Operations
    private func setUI() {
        addSubview(descriptionLabel)

        descriptionLabel.snp.makeConstraints { (make) in
            make.leading.top.trailing.bottom.equalToSuperview().offset(24).inset(24)
        }

        let attributedText = NSMutableAttributedString(string: "Great games", attributes: [.foregroundColor: UIColor.black])
        attributedText.append(NSMutableAttributedString(string: " are all about the details, from subtle visual effects to imaginative art styles. In these titles, you're sure to find something to marvel at, whether you're into fantasy worlds or neon-soaked dartboards.", attributes: [.foregroundColor: UIColor.gray]))

        descriptionLabel.attributedText = attributedText
    }

    // MARK:- Components
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Description"
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
}
