//
//  PersonTableViewCell.swift
//  PhoneBook
//
//  Created by Максим Журавлев on 12.03.25.
//

// Views/ItemTableViewCell.swift
import UIKit
import SnapKit

class PersonTableViewCell: UITableViewCell {
    static let reuseIdentifier = "PerosnTableViewCell"
    
    //Создаю элементы
    lazy var jobTitleLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.numberOfLines = 0
        nameLabel.font = UIFont.systemFont(ofSize: 10, weight: .light)
        return nameLabel
    }()
    
    lazy var personNameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.numberOfLines = 0
        nameLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        return nameLabel
    }()
    
    private lazy var wrapWorkPhoneView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var workPhoneLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.numberOfLines = 0
        nameLabel.font = UIFont.systemFont(ofSize: 10, weight: .light)
        return nameLabel
    }()
    
    private lazy var wrapCityPhoneView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var cityPhoneLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.numberOfLines = 0
        nameLabel.font = UIFont.systemFont(ofSize: 10, weight: .light)
        return nameLabel
    }()
    
    private lazy var wrapBuildingRoomView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var buildingRoomLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.numberOfLines = 0
        nameLabel.font = UIFont.systemFont(ofSize: 10, weight: .light)
        return nameLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with person: Person) {

        jobTitleLabel.text = person.jobTitle
        personNameLabel.text = person.personName
        workPhoneLabel.text = person.workPhone
        cityPhoneLabel.text = person.cityPhone
        buildingRoomLabel.text = person.buildingRoom
        
        contentView.addSubview(jobTitleLabel)
        contentView.addSubview(personNameLabel)
        contentView.addSubview(wrapWorkPhoneView)
        contentView.addSubview(wrapCityPhoneView)
        contentView.addSubview(wrapBuildingRoomView)
        wrapWorkPhoneView.addSubview(workPhoneLabel)
        wrapCityPhoneView.addSubview(cityPhoneLabel)
        wrapBuildingRoomView.addSubview(buildingRoomLabel)
        
        updateViewConstraints()
        
    }
    
    //MARK: - Работа с констрейнтами
    func updateViewConstraints() {
        jobTitleLabel.snp.makeConstraints {
            $0.left.top.equalToSuperview().inset(10)
            $0.trailing.equalTo(contentView.snp.centerX)
        }
        
        personNameLabel.snp.makeConstraints {
            $0.left.equalToSuperview().inset(10)
            $0.top.equalTo(jobTitleLabel.snp.bottom).offset(10)
            $0.bottom.equalToSuperview().inset(10)
            $0.trailing.equalTo(contentView.snp.centerX)
        }
        
        wrapWorkPhoneView.snp.makeConstraints {
            $0.leading.equalTo(contentView.snp.centerX)
            $0.width.equalTo(contentView.snp.width).multipliedBy(0.10)
            $0.top.bottom.equalToSuperview().inset(5)
        }
        
        wrapCityPhoneView.snp.makeConstraints {
            $0.leading.equalTo(wrapWorkPhoneView.snp.trailing).offset(2)
            $0.trailing.equalTo(wrapBuildingRoomView.snp.leading).offset(-2)
            //$0.width.equalTo(contentView.snp.width).multipliedBy(0.16)
            $0.top.bottom.equalToSuperview().inset(5)
        }
        
        wrapBuildingRoomView.snp.makeConstraints {
            //$0.leading.equalTo(wrapCityPhoneView.snp.trailing).offset(2)
            $0.width.equalTo(contentView.snp.width).multipliedBy(0.10)
            $0.top.bottom.right.equalToSuperview().inset(5)
        }
        
        workPhoneLabel.snp.makeConstraints {
            $0.left.top.bottom.equalToSuperview().inset(5)
        }
        
        cityPhoneLabel.snp.makeConstraints {
            $0.left.top.bottom.equalToSuperview().inset(5)
        }
        
        buildingRoomLabel.snp.makeConstraints {
            $0.left.top.bottom.right.equalToSuperview().inset(1)
        }
        
    }
}
