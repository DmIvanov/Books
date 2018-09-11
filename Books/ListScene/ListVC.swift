//
//  ListVC.swift
//  Books
//
//  Created by Dmitrii on 18/09/2017.
//  Copyright © 2017 DI. All rights reserved.
//

import UIKit


class ListVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating, UISearchBarDelegate, ListCellDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        
    }


    // MARK: - Properties
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var rightBarButton: UIBarButtonItem!
    var searchController: UISearchController!

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
        configureSearchController()
    }


    // MARK: - Public
    func setDataModel(dataModel: ListVCDataModel) {
        self.dataModel = dataModel
    }

    @objc func booksRefreshed() {
        dataModel.refreshBooksArray()
        tableView.reloadData()
    }


    // MARK: - Private
    func configureSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = true
        searchController.searchBar.placeholder = "Search here..."
        searchController.searchBar.delegate = self
        searchController.searchBar.sizeToFit()

        tableView.tableHeaderView = searchController.searchBar
    }


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
            cell.adjust(model: model)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        dataModel.bookWasChosen(index: indexPath.row)
    }


    // MARK: - UISearchBarDelegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        dataModel.loadBooks(query: searchText)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchController.searchBar.resignFirstResponder
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {

    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {

    }


    // MARK: - ListCellDelegate
    func cellReadButtonTapped(cell: ListCell) {
        dataModel.changeBookRead(bookId: cell.model.bookID)
    }
}



