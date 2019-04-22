//
//  AppFullScreenController.swift
//  AppStoreTest
//
//  Created by Charlie Tuna on 2019-04-21.
//  Copyright © 2019 Charlie Tuna. All rights reserved.
//

import UIKit

class AppFullScreenController: UITableViewController {

    // MARK:- Properties
    let cellIdentifier = "cellIdentifier"
    var dismissHandler: (()->Void)?

    // MARK:- Init
    init() {
        super.init(style: .grouped)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    // MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.backgroundColor = .white
        tableView.showsVerticalScrollIndicator = false
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.allowsSelection = false

        tableView.register(AppFullScreenDescriptionCell.self, forCellReuseIdentifier: cellIdentifier)
    }

    // MARK:- TableView
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = AppFullScreenHeaderCell()
        header.closeButton.addTarget(self, action: #selector(onCancelAction), for: .touchUpInside)

        return header
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 400
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! AppFullScreenDescriptionCell

        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    @objc func onCancelAction(sender: UIButton) {
        sender.isHidden = true
        dismissHandler?()
    }
}
