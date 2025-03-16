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
        }
        
    }
}

// MARK: - UITableViewDataSource
extension PersonViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfPersons
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PersonTableViewCell.reuseIdentifier, for: indexPath) as! PersonTableViewCell
        let person = viewModel.person(at: indexPath.row)
        cell.configure(with: person)
        return cell
    }
}

