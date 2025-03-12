//
//  MainViewModel.swift
//  PhoneBook
//
//  Created by Максим Журавлев on 11.03.25.
//

// ViewModels/ItemViewModel.swift
import Foundation

class ItemViewModel {
    private var items: [Item] = []
    
    var numberOfItems: Int {
        return items.count
    }
    
    func item(at index: Int) -> Item {
        return items[index]
    }
    
    func loadData(completion: @escaping () -> Void) {
        // Используем сервис для парсинга HTML
        DispatchQueue.global(qos: .background).async {
            self.items = HTMLParser.parseHTML(from: "example")
            DispatchQueue.main.async {
                completion()
            }
        }
    }
}
