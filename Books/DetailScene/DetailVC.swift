//
//  DetailVC.swift
//  Books
//
//  Created by Dmitrii on 19/09/2017.
//  Copyright © 2017 DI. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {

    // MARK: - Properties
    private var dataModel: DetailVCDataModel!

    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var authorsLabel: UILabel!
    @IBOutlet private var subtitleLabel: UILabel!
    @IBOutlet private var snippetLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!
    @IBOutlet private var ratingLabel: UILabel!


    // MARK: - Lyfecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = dataModel.title
        titleLabel.text = dataModel.title
        authorsLabel.text = dataModel.authors
        subtitleLabel.text = dataModel.subtitle
        snippetLabel.text = dataModel.snippet
        descriptionLabel.text = dataModel.description
        ratingLabel.text = dataModel.rating

        ImageDownloader().downloadImage(url: URL(string: dataModel.imageURL)!) { [weak self] (image) in
            self?.imageView.image = image
        }
    }


    // MARK: - Public
    func setDataService(ds: DataService) {
        dataModel = DetailVCDataModel(dataService: ds)
    }

    func setTheBook(book: Book) {
        dataModel.setTheBook(book: book)
    }

    // MARK: - Private


    // MARK: - Actions
}
