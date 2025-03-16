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
    private var personsGrouped: [String: [Person]] = [:]
    
    var numberOfPersons: Int {
        return persons.count
    }
    
    var groupsOfPersons: [String: [Person]] {
        return personsGrouped
    }
    
    func person(at index: Int) -> Person {
        return persons[index]
    }
    
    
    
    func loadData(completion: @escaping () -> Void) {
        // Используем сервис для парсинга HTML
        DispatchQueue.global(qos: .background).async {
            self.persons = HTMLParser.parseHTMLForPersons(from: HtmlEnum.phoneBook.rawValue)
            self.groups = HTMLParser.parseHTMLForGroups(from: HtmlEnum.phoneBook.rawValue)
            self.personsGrouped = self.dividePeopleToGroups(self.persons, by: self.groups)
            DispatchQueue.main.async {
                completion()
            }
        }
    }

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

}
