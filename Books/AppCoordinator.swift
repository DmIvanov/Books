//
//  AppCoordinator.swift
//  Books
//
//  Created by Dmitrii on 18/09/2017.
//  Copyright © 2017 DI. All rights reserved.
//

import UIKit


class AppCoordinator: NSObject {

    // MARK: - Properties
    private let presenter: Presenter
    fileprivate let dataService: DataService

    // MARK: - Lyfecycle
    init(mainWindow: UIWindow) {
        self.dataService = ServicesFactory.dataService()
        self.presenter = ServicesFactory.presenter(window: mainWindow)
    }


    // MARK: - Public
    func appDidLaunched(options: [UIApplicationLaunchOptionsKey: Any]?) {
        goToListScreen()
    }


    // MARK: - Private
    fileprivate func goToListScreen() {
        let listVC = ViewControllerFactory.listVC(
            dataService: dataService,
            delegate: self
        )
        presenter.resetWindow(vc: listVC)
    }

    fileprivate func goToBookDetailView(book: Book) {
        let detailVC = ViewControllerFactory.detailVC(
            dataService: dataService,
            book: book,
            delegate: self
        )
        presenter.push(vc: detailVC, animated: true)
    }

    // MARK: - Actions
}


// ----------------------------------------------------------------------------
// MARK: - ListSceneDelegate
// ----------------------------------------------------------------------------
extension AppCoordinator: ListSceneDelegate {
    func bookWasChosen(book: Book) {
        goToBookDetailView(book: book)
    }
}


// ----------------------------------------------------------------------------
// MARK: - DetailSceneDelegate
// ----------------------------------------------------------------------------
extension AppCoordinator: DetailSceneDelegate {}
