//
//  AppsHeader.swift
//  AppStoreTest
//
//  Created by Charlie Tuna on 2019-04-19.
//  Copyright © 2019 Charlie Tuna. All rights reserved.
//

import UIKit
import SnapKit

class AppsHeader: UICollectionReusableView {

    // MARK:- Init
    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .lightGray
        setUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK:- UI
    private func setUI() {
        addSubview(appsHeaderHorizontalController.view)

        appsHeaderHorizontalController.view.snp.makeConstraints { (make) in
            make.leading.top.trailing.bottom.equalToSuperview()
        }
    }

    // MARK:- Components
    let appsHeaderHorizontalController = AppsHeaderHorizontalController()
}
