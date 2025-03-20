//
//  ViewController.swift
//  PhoneBook
//
//  Created by Максим Журавлев on 11.03.25.
//

// Views/ItemViewController.swift
import UIKit

class PersonViewController: UIViewController {
    private let viewModel = PersonViewModel()
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        loadData()
        
        
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.register(PersonTableViewCell.self, forCellReuseIdentifier: PersonTableViewCell.reuseIdentifier)
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension // Автоматическая высота
        tableView.estimatedRowHeight = 100 // Примерная высота для оптимизации

    }
    
    private func loadData() {
        viewModel.loadData { [weak self] in
            self?.tableView.reloadData()
        }
        
    }
}

// MARK: - UITableViewDataSource
extension PersonViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.arrayOfGroups.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        //return viewModel.arrayOfGroups[section].keys.first //groupId
        let group = viewModel.arrayOfGroups[section]
        if let persons = group.values.first, let firstPerson = persons.first {
            return firstPerson.groupIdName
        }
        return nil
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let group = viewModel.arrayOfGroups[section]
        return group.values.first?.count ?? 0 //Количество Person в группе
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PersonTableViewCell.reuseIdentifier, for: indexPath) as! PersonTableViewCell
        
        let group = viewModel.arrayOfGroups[indexPath.section]
        
        if let persons = group.values.first { //first применяем для проверки, что объект точно есть, что он не нил
            let person = persons[indexPath.row]
            cell.configure(with: person)
        }
        
        return cell
    }
}

