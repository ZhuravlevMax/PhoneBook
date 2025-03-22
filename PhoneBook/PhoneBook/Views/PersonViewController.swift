//
//  ViewController.swift
//  PhoneBook
//
//  Created by Максим Журавлев on 11.03.25.
//

// Views/ItemViewController.swift
import UIKit

class PersonViewController: UIViewController, UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else {
            return
        }
        
        allPersons = viewModel.getAllPersons()
        filteredData = allPersons.filter {
            $0.personName.lowercased().contains(searchText.lowercased())
        }
        tableView.reloadData()
    }
    
    private let viewModel = PersonViewModel()
    private let tableView = UITableView()
    private var filteredData = [Person]()
    private var allPersons = [Person]()
    private var isSearching: Bool {
        return searchController.isActive && ((searchController.searchBar.text?.isEmpty) == nil)
    }
    
    private let searchController = UISearchController(searchResultsController: nil)
    
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
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Найти сотрудника"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        navigationItem.hidesSearchBarWhenScrolling = false

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
        return filteredData.isEmpty ? viewModel.arrayOfGroups.count : 1
       // viewModel.arrayOfGroups.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        //return viewModel.arrayOfGroups[section].keys.first //groupId
        if filteredData.isEmpty {
            let group = viewModel.arrayOfGroups[section]
            if let persons = group.values.first, let firstPerson = persons.first {
                return firstPerson.groupIdName
            }
            return nil
        }
        return nil
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let group = viewModel.arrayOfGroups[section]
        return filteredData.isEmpty ? group.values.first?.count ?? 0 : filteredData.count
        //return group.values.first?.count ?? 0 //Количество Person в группе
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PersonTableViewCell.reuseIdentifier, for: indexPath) as! PersonTableViewCell
        
        let group = viewModel.arrayOfGroups[indexPath.section]
        
        if filteredData.isEmpty {
            if let persons = group.values.first { //first применяем для проверки, что объект точно есть, что он не нил
                let person = persons[indexPath.row]
                cell.configure(with: person)
            }
        } else {
            let person = filteredData[indexPath.row]
            cell.configure(with: person)
        }
        
        
        return cell
    }
    
}

