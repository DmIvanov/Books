//
//  MainInteractor.swift
//  Books
//
//  Created by Dmitrii on 18/09/2017.
//  Copyright © 2017 DI. All rights reserved.
//

import UIKit


class MainInteractor: NSObject {

    // MARK: - Properties
    private weak var window: UIWindow?
    fileprivate let dataService = DataService()

    // MARK: - Lyfecycle
    init(mainWindow: UIWindow?) {
        window = mainWindow
    }


    // MARK: - Public
    func appDidLaunched(options: [UIApplicationLaunchOptionsKey: Any]?) {
        goToListScreen()
        window?.makeKeyAndVisible()
    }


    // MARK: - Private
    private func goToListScreen() {
        let listVC = ViewControllerFactory.listVC()
        listVC.setDataService(ds: dataService)
        let nc = UINavigationController(rootViewController: listVC)
        window?.rootViewController = nc
    }


    // MARK: - Actions
}
