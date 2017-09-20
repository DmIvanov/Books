//
//  ListVC.swift
//  Books
//
//  Created by Dmitrii on 18/09/2017.
//  Copyright © 2017 DI. All rights reserved.
//

import UIKit


class ListVC: UIViewController, UITableViewDelegate, UITableViewDataSource, ListCellDelegate {

    // MARK: - Properties
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var rightBarButton: UIBarButtonItem!
    private var dataModel: ListVCDataModel!
    

    // MARK: - Lyfecycle
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(booksRefreshed),
            name: dataServiceBooksRefreshedNotification,
            object: nil
        )
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }


    // MARK: - Public
    func setDataService(ds: DataService) {
        dataModel = ListVCDataModel(dataService: ds)
    }

    @objc func booksRefreshed() {
        dataModel.refreshBooksArray()
        tableView.reloadData()
    }


    // MARK: - Private


    // MARK: - Actions
    @IBAction private func rightBarButtonPressed() {
        dataModel.changeTopRated()
        rightBarButton.title = dataModel.justTopRated ? "Top Rated" : "All"
        tableView.reloadData()
    }


    // MARK: - UITableView
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModel.booksAmount()
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCellId", for: indexPath) as! ListCell
        cell.delegate = self
        if let model = dataModel.model(index: indexPath.row) {
            cell.adjust(model: model, index: UInt(indexPath.row))
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let model = dataModel.model(index: indexPath.row) {
            let detailVC = ViewControllerFactory.detailVC()
            detailVC.setDataService(ds: dataModel.dataService)
            if let book = dataModel.book(forId: model.bookID) {
                detailVC.setTheBook(book: book)
                navigationController?.pushViewController(detailVC, animated: true)
            }
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }


    // MARK: - ListCellDelegate
    func cellReadButtonTapped(cell: ListCell) {
        dataModel.changeBookRead(bookId: cell.model.bookID)
    }
}



