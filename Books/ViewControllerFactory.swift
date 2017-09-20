//
//  ViewControllerFactory.swift
//  Books
//
//  Created by Dmitrii on 19/09/2017.
//  Copyright © 2017 DI. All rights reserved.
//

import UIKit

class ViewControllerFactory {

    class func mainStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }

    class func listVC() -> ListVC {
        return mainStoryboard().instantiateViewController(withIdentifier: "ListVC") as! ListVC
    }

    class func detailVC() -> DetailVC {
        return mainStoryboard().instantiateViewController(withIdentifier: "DetailVC") as! DetailVC
    }
}
