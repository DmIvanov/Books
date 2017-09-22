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

    @IBOutlet private var indexLabel: UILabel!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var readButton: UIButton!


    // MARK: - Lyfecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


    // MARK: - Public
    func adjust(model: ListCellModel) {
        self.model = model
        titleLabel.text = model.title
        indexLabel.text = "\(model.index). "
        let alternativeColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
        backgroundColor = (model.index%2 == 0) ? UIColor.white : alternativeColor
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
    let title: String
    let index: UInt
    var read: Bool

    init(book: Book, idx: UInt) {
        bookID = book.id
        title = book.title
        read = book.read
        index = idx
    }
}
