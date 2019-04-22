//
//  BaseTabBarController.swift
//  AppStoreTest
//
//  Created by Charlie Tuna on 2019-04-06.
//  Copyright © 2019 Charlie Tuna. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()

        viewControllers = [
            navigationController(with: todayVC, title: "Today", tabBarImage: #imageLiteral(resourceName: "today_icon")),
            navigationController(with: appsVC, title: "Apps", tabBarImage: #imageLiteral(resourceName: "apps")),
            navigationController(with: searchVC, title: "Search", tabBarImage: #imageLiteral(resourceName: "search"))
        ]
    }

    private func navigationController(with controller: UIViewController, title: String, tabBarImage: UIImage) -> UIViewController {
        controller.title = title
        let nav = UINavigationController(rootViewController: controller)
        nav.title = title
        nav.navigationBar.prefersLargeTitles = true
        nav.tabBarItem.image = tabBarImage
        return nav
    }

    // MARK:- Components
    let todayVC = TodayController()
    let appsVC = AppsController()
    let searchVC = SearchController()
}
