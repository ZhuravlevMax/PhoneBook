//
//  PersonViewModel.swift
//  PhoneBook
//
//  Created by Максим Журавлев on 16.03.25.
//

import Foundation

class PersonViewModel {
    private var persons: [Person] = []
    private var groups: [String: String] = [:]
    
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
//
//    struct People {
//        let id: Int
//        let groupId: Int
//        let name: String
//    }

    func dividePeopleToGroups(_ persons: [Person], by groups: [String: String]) -> [String: [Person]] {
        
        var groupedPersons: [String: [Person]] = [:]
        
        for person in persons {
            let groupId = person.groupId
            
            if groupedPersons[groupId] == nil {
                groupedPersons[groupId] = []
            }
            groupedPersons[groupId]?.append(person)
        }
        
        return groupedPersons
    }

    // Пример использования
//    let peoples = [
//        People(id: 1, groupId: 1, name: "Alice"),
//        People(id: 2, groupId: 2, name: "Bob"),
//        People(id: 3, groupId: 1, name: "Charlie"),
//        People(id: 4, groupId: 3, name: "David"),
//        People(id: 5, groupId: 2, name: "Eve")
//    ]
//
//    let groups = [
//        1: "Group A",
//        2: "Group B",
//        3: "Group C"
//    ]
//
//    let groupedPeoples = groupPeoples(peoples, by: groups)
//
//    // Вывод результата
//    for (groupId, peoples) in groupedPeoples {
//        if let groupName = groups[groupId] {
//            print("Group \(groupName):")
//            for people in peoples {
//                print("  \(people.name)")
//            }
//        }
//    }
}
