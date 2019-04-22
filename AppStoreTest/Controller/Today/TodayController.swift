//
//  TodayController.swift
//  AppStoreTest
//
//  Created by Charlie Tuna on 2019-04-20.
//  Copyright © 2019 Charlie Tuna. All rights reserved.
//

import UIKit

class TodayController: UICollectionViewController {

    // MARK:- Properties
    let cellIdentifier = "cellIdentifier"
    var startingFrame: CGRect?
    var appFullScreenController: AppFullScreenController!
    var top: NSLayoutConstraint?
    var leading: NSLayoutConstraint?
    var height: NSLayoutConstraint?
    var width: NSLayoutConstraint?

    // MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.isNavigationBarHidden = true

        collectionView.backgroundColor = UIColor.init(white: 0.95, alpha: 1.0)
        collectionView.contentInset = .init(top: 16, left: 0, bottom: 16, right: 0)
        collectionView.showsVerticalScrollIndicator = false

        collectionView.register(TodayCell.self, forCellWithReuseIdentifier: cellIdentifier)
    }

    // MARK:- Init
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    // MARK:- CollectionView
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)

        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
        guard let startingFrame = cell.superview?.convert(cell.frame, to: nil) else { return }
        self.startingFrame = startingFrame
        showDetailView()
    }

    // MARK:- Operations
    private func showDetailView() {

        let appFullScreenController = AppFullScreenController()

        appFullScreenController.dismissHandler = {
            self.handleRemoveView(view: appFullScreenController.view)
        }

        self.appFullScreenController = appFullScreenController

        guard let frame = self.startingFrame else { return }

        addChild(appFullScreenController)

        let fullScreenView = appFullScreenController.view!

        fullScreenView.layer.cornerRadius = 16
        fullScreenView.translatesAutoresizingMaskIntoConstraints = false

        self.view.addSubview(fullScreenView)

        top = fullScreenView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: frame.origin.y)
        leading = fullScreenView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: frame.origin.x)
        width = fullScreenView.widthAnchor.constraint(equalToConstant: frame.width)
        height = fullScreenView.heightAnchor.constraint(equalToConstant: frame.height)

        [top, leading, width, height].forEach({ $0?.isActive = true })
        self.view.layoutIfNeeded()

        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {

            self.top?.constant = 0
            self.leading?.constant = 0
            self.width?.constant = self.view.frame.width
            self.height?.constant = self.view.frame.height
            self.view.layoutIfNeeded()

            self.tabBarController?.tabBar.transform = .init(translationX: 0, y: 100)
        }, completion: nil)
    }

    // MARK:- Objc
    @objc func handleRemoveView(view: UIView) {

        guard let frame = self.startingFrame else { return }

        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {

            self.top?.constant = frame.origin.y
            self.leading?.constant = frame.origin.x
            self.width?.constant = frame.width
            self.height?.constant = frame.height
            self.appFullScreenController.tableView.contentOffset = .zero
            self.view.layoutIfNeeded()

            self.tabBarController?.tabBar.transform = .identity
        }, completion: { _ in
            view.removeFromSuperview()
            self.appFullScreenController.removeFromParent()
        })
    }
}

extension TodayController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: collectionView.frame.width*0.8, height: 400)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 32
    }
}
