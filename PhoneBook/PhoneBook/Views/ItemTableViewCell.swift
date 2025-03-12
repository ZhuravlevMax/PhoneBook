//
//  ItemTableViewCell.swift
//  PhoneBook
//
//  Created by Максим Журавлев on 12.03.25.
//

// Views/ItemTableViewCell.swift
import UIKit

class ItemTableViewCell: UITableViewCell {
    static let reuseIdentifier = "ItemTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with item: Item) {
        textLabel?.text = item.title
        detailTextLabel?.text = item.link
    }
}
