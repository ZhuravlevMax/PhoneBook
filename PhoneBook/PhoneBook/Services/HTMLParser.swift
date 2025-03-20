//
//  HTMLParser.swift
//  PhoneBook
//
//  Created by Максим Журавлев on 12.03.25.
//

// Services/HTMLParser.swift
import Foundation
import SwiftSoup

class HTMLParser {
    
    static func parseHTMLForGroups(from fileName: String) -> [Group] {
        var groups: [Group] = []
        
        // Получаем путь к файлу
        guard let filePath = Bundle.main.path(forResource: HtmlEnum.phoneBook.rawValue, ofType: "html") else {
            print("Файл не найден")
            return groups
        }
        
        do {
            
            // Чтение содержимого файла
            let html = try String(contentsOfFile: filePath, encoding: .utf8)
            
            // Парсинг HTML
            let document = try SwiftSoup.parse(html)
            
            // создаю словарь с ID группамми и их названиями
            let tagsOfGroups = try document.select("a")
            
            for tag in tagsOfGroups {
                
                var id = try tag.attr("href")
                
                let nameOfGroup = try tag.text()
                
                
                if id.hasPrefix("#group") {
                    id = String(id.dropFirst(9))
                    let group = Group(id: id, groupName: nameOfGroup)
                    groups.append(group)
                }
                
            }
            
        } catch {
            print("Ошибка при парсинге HTML: \(error)")
        }
        
        return groups
    }
    
    static func parseHTMLForPersons(from fileName: String) -> [Person] {
        var persons = [Person]()
        let groups = self.parseHTMLForGroups(from: HtmlEnum.phoneBook.rawValue)
        
        // Получаем путь к файлу
        guard let filePath = Bundle.main.path(forResource: HtmlEnum.phoneBook.rawValue, ofType: "html") else {
            print("Файл не найден")
            return persons
        }
        
        do {
            
            // Чтение содержимого файла
            let html = try String(contentsOfFile: filePath, encoding: .utf8)
            
            // Парсинг HTML
            let document = try SwiftSoup.parse(html)
            
            //Создаю объекты Person
            let tagsOfPerson = try document.select("tr")
            
            for tag in tagsOfPerson {
                var groupId = try tag.attr("class")
                
                var groupIdName: String = ""
                
                if groupId.hasPrefix("SortList") {
                    
                    //Получаю ID группы для Person
                    groupId = String(groupId.dropFirst(9))
                    
                    for group in groups {
                        if group.id == groupId {
                            groupIdName = group.groupName
                        }
                    }
                    
                    let personId = try tag.attr("id")
                    
                    //Получаю должность для Person
                    //Здесь я получил должность с именем. Чтобы оставить только должность, я делаю должность с маленькой буквы и убирают весь текст, который начинается с больщой буквы (Имя)
                    let personName = try tag.select("strong").text()
                    var jobTitle = try tag.select("td:nth-child(2)").text()
                    
                    //убираю фамилию из должности
                    let jobTitleWords = jobTitle.components(separatedBy: .whitespaces)
                    let personNameWords = personName.components(separatedBy: .whitespaces)
                    let filteredJobTitle = jobTitleWords.filter {
                        !personNameWords.contains($0)
                    }
                    
                    jobTitle = filteredJobTitle.joined(separator: " ")
                    
                    let workPhone = try tag.select("td:nth-child(3)").text()
                    let cityPhone = try tag.select("td:nth-child(4)").text()
                    let buildingRoom = try tag.select("td:nth-child(5)").text()
                    
                    let person = Person(groupId: groupId,groupIdName: groupIdName, personId: personId, jobTitle: jobTitle, personName: personName, workPhone: workPhone, cityPhone: cityPhone, buildingRoom: buildingRoom)
                    persons.append(person)
                }
                
                
            }
            
        } catch {
            print("Ошибка при парсинге HTML: \(error)")
        }
        
        return persons
    }
}
