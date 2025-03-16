//
//  PersonViewModel.swift
//  PhoneBook
//
//  Created by Максим Журавлев on 16.03.25.
//

import Foundation

class PersonViewModel {
    private var persons: [Person] = []
    
    var numberOfPersons: Int {
        return persons.count
    }
    
    func person(at index: Int) -> Person {
        return persons[index]
    }
    
    func loadData(completion: @escaping () -> Void) {
        // Используем сервис для парсинга HTML
        DispatchQueue.global(qos: .background).async {
            self.persons = HTMLParser.parseHTML(from: HtmlEnum.phoneBook.rawValue)
            DispatchQueue.main.async {
                completion()
            }
        }
    }
}
