//
//  ListCell.swift
//  Books
//
//  Created by Dmitrii on 19/09/2017.
//  Copyright © 2017 DI. All rights reserved.
//

import UIKit


class ListCell: UITableViewCell {

    // MARK: - Properties
    weak var delegate: ListCellDelegate?

    private(set) var model: ListCellModel!

    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var readButton: UIButton!


    // MARK: - Lyfecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


    // MARK: - Public
    func adjust(model: ListCellModel, index: UInt) {
        self.model = model
        titleLabel.text = "\(index + 1). " + model.bookTitle
        adjustReadButton()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }


    // MARK: - Private
    private func adjustReadButton() {
        let title = model.read ? "read" : "pending"
        readButton.setTitle(title, for: .normal)
    }


    // MARK: - Actions
    @IBAction private func readButtonTapped() {
        model.read = !model.read
        adjustReadButton()
        delegate?.cellReadButtonTapped(cell: self)
    }
}


protocol ListCellDelegate: class {
    func cellReadButtonTapped(cell: ListCell)
}


struct ListCellModel {

    let bookID: String
    let bookTitle: String
    var read: Bool

    init(book: Book) {
        bookID = book.id
        bookTitle = book.title
        read = book.read
    }
}
