//
//  ViewController.swift
//  PhoneBook
//
//  Created by Максим Журавлев on 11.03.25.
//

// Views/ItemViewController.swift
import UIKit

class ItemViewController: UIViewController {
    private let viewModel = ItemViewModel()
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        loadData()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.register(ItemTableViewCell.self, forCellReuseIdentifier: ItemTableViewCell.reuseIdentifier)
        tableView.dataSource = self
    }
    
    private func loadData() {
        viewModel.loadData { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

// MARK: - UITableViewDataSource
extension ItemViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ItemTableViewCell.reuseIdentifier, for: indexPath) as! ItemTableViewCell
        let item = viewModel.item(at: indexPath.row)
        cell.configure(with: item)
        return cell
    }
}

