//
//  AppFullScreenHeaderCell.swift
//  AppStoreTest
//
//  Created by Charlie Tuna on 2019-04-21.
//  Copyright © 2019 Charlie Tuna. All rights reserved.
//

import UIKit

class AppFullScreenHeaderCell: UITableViewCell {

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

        closeButton.setTitle("X", for: .normal)
        closeButton.setTitleColor(.white, for: .normal)
        closeButton.backgroundColor = .blue
        closeButton.layer.cornerRadius = 16

        addSubview(todayCell)
        addSubview(closeButton)

        todayCell.snp.makeConstraints { (make) in
            make.leading.top.trailing.bottom.equalToSuperview()
        }

        closeButton.snp.makeConstraints { (make) in
            make.height.width.equalTo(32)
            make.top.trailing.equalToSuperview().offset(16).inset(16)
        }
    }

    // MARK:- Components
    let todayCell = TodayCell()
    let closeButton = UIButton(type: .system)

}
