//
//  ServiceFactory.swift
//  Books
//
//  Created by Dmitrii Ivanov on 11/09/2018.
//  Copyright © 2018 DI. All rights reserved.
//

import UIKit

class ServicesFactory {

    class func presenter(window: UIWindow) -> Presenter {
        return Presenter(window: window)
    }

    class func dataService() -> DataService {
        return DataService()
    }
}
