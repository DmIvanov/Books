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

    class func listVC(dataService: DataService, delegate: ListSceneDelegate) -> ListVC {
        let listVC = mainStoryboard().instantiateViewController(withIdentifier: "ListVC") as! ListVC
        let listDataModel = ListVCDataModel(
            dataService: dataService,
            viewController: listVC,
            delegate: delegate
        )
        listVC.setDataModel(dataModel: listDataModel)
        return listVC
    }

    class func detailVC(dataService: DataService, book: Book, delegate: DetailSceneDelegate) -> DetailVC {
        let vc = mainStoryboard().instantiateViewController(withIdentifier: "DetailVC") as! DetailVC
        let detailDataModel = DetailVCDataModel(
            dataService: dataService,
            book: book,
            delegate: delegate
        )
        vc.setDataModel(dataModel: detailDataModel)
        return vc
    }
}
