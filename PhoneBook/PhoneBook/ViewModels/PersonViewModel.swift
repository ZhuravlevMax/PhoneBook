//
//  PersonViewModel.swift
//  PhoneBook
//
//  Created by Максим Журавлев on 16.03.25.
//

import Foundation

class PersonViewModel {
    private var persons: [Person] = []
    private var groups: [Group] = []
    private var personsGrouped: [[String: [Person]]] = [[:]]
    
    var numberOfPersons: Int {
        return persons.count
    }
    
    var arrayOfGroups: [[String: [Person]]] {
        return personsGrouped
    }
    
    func person(at index: Int) -> Person {
        return persons[index]
    }
    
    func getAllPersons() -> [Person] {
        return persons
    }
    
    func loadData(completion: @escaping () -> Void) {

        // Используем сервис для парсинга HTML
        DispatchQueue.global(qos: .background).async {
            self.persons = HTMLParser.parseHTMLForPersons(from: HtmlEnum.phoneBook.rawValue)
            self.groups = HTMLParser.parseHTMLForGroups(from: HtmlEnum.phoneBook.rawValue)
            self.personsGrouped = self.dividePeopleToGroups(self.persons)
            DispatchQueue.main.async {
                completion()
            }
        }

        
    }
    
//    func getAllPersons(completion: @escaping () -> Void) {
//        DispatchQueue.global(qos: .background).async {
//            self.persons = HTMLParser.parseHTMLForPersons(from: HtmlEnum.phoneBook.rawValue)
//            DispatchQueue.main.async {
//                completion()
//            }
//        }
//    }
    
    func dividePeopleToGroups(_ persons: [Person]) -> [[String: [Person]]] {
        
        var groupedPersons: [String: [Person]] = [:]
        var groupOrder: [String] = [] // Массив для сохранения порядка групп
        
        //группируем persons по groupId и сохраняем порядок групп
        for person in persons {
            let groupId = person.groupId
            
            if groupedPersons[groupId] == nil {
                groupedPersons[groupId] = []
                
                groupOrder.append(groupId) // Сохраняем порядок появления groupId
                
            }
            
            groupedPersons[groupId]?.append(person)
            
        }
        //Создаем массив словарей с сохранением порядка групп
        
        let arrayOfGroups: [[String: [Person]]] = groupOrder.map {
            groupId in
            return [groupId: groupedPersons[groupId] ?? []]
        }
        
        return arrayOfGroups
    }
    
}
