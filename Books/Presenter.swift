//
//  Presenter.swift
//  Books
//
//  Created by Dmitrii Ivanov on 08/09/2018.
//  Copyright © 2018 DI. All rights reserved.
//

import UIKit


class Presenter {

    private var window: UIWindow
    private var rootNC: UINavigationController?

    init(window: UIWindow) {
        self.window = window
        window.makeKeyAndVisible()
    }

    func resetWindow(vc: UIViewController) {
        rootNC = UINavigationController(rootViewController: vc)
        window.rootViewController = rootNC!
    }

    func push(vc: UIViewController, animated: Bool) {
        rootNC?.pushViewController(vc, animated: animated)
    }
}
