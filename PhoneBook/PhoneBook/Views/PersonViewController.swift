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
    }
    
    private func loadData() {
        viewModel.loadData { [weak self] in
            self?.tableView.reloadData()
            print(self?.viewModel.groupsOfPersons["91cd0718-2d11-43ee-a2b2-e7898b2d662b"])
        }
        
    }
}

// MARK: - UITableViewDataSource
extension PersonViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.groupsOfPersons.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return viewModel.numberOfPersons
        let key = Array(viewModel.groupsOfPersons.keys)[section]
        return viewModel.groupsOfPersons[key]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PersonTableViewCell.reuseIdentifier, for: indexPath) as! PersonTableViewCell
        let key = Array(viewModel.groupsOfPersons.keys)[indexPath.section]
        if let person = viewModel.groupsOfPersons[key]?[indexPath.row] {
            cell.configure(with: person)
        }
        //let person = viewModel.person(at: indexPath.row)
        
        return cell
    }
}

