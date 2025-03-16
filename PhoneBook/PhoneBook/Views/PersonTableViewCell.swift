//
//  PersonTableViewCell.swift
//  PhoneBook
//
//  Created by Максим Журавлев on 12.03.25.
//

// Views/ItemTableViewCell.swift
import UIKit

class PersonTableViewCell: UITableViewCell {
    static let reuseIdentifier = "PerosnTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with person: Person) {
        textLabel?.text = person.personName
        detailTextLabel?.text = person.jobTitle
        
    }
}
