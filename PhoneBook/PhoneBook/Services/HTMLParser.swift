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
    static func parseHTML(from fileName: String) -> [Item] {
        var items = [Item]()
        var persons = [Person]()
        
        // Получаем путь к файлу
        guard let filePath = Bundle.main.path(forResource: HtmlEnum.phoneBook.rawValue, ofType: "html") else {
            print("Файл не найден")
            return items
        }
        
        do {
            // Чтение содержимого файла
            let html = try String(contentsOfFile: filePath, encoding: .utf8)
            
            // Парсинг HTML
            let document = try SwiftSoup.parse(html)

            // создаю словарь с ID группамми и их названиями
            let tagsOfGroups = try document.select("a")
            var groupDict = [String:String]()
            for tag in tagsOfGroups {
                
                var id = try tag.attr("href")
            
                let nameOfGroup = try tag.text()
                
                if id.hasPrefix("#group") {
                    id = String(id.dropFirst(9))
                    groupDict.updateValue(nameOfGroup, forKey: id)
//                    let item = Item(title: groupDict[id] ?? "", link: "")
//                    items.append(item)
                }

            }
            
            //Создаю объекты Person
            var tagsOfPerson = try document.select("tr")

            for tag in tagsOfPerson {
                var groupId = try tag.attr("class")
                if groupId.hasPrefix("SortList") {
                    groupId = String(groupId.dropFirst(9))
                    var personId = try tag.attr("id")
                    var nameOfPerson = try tag.text()
                    let person = Person(groupId: groupId, personId: personId, name: nameOfPerson)
                    persons.append(person)
                }
                
        
            }
            
            //print(groupDict)
            //print(persons)
            print(persons.count)
            print(persons[1].groupId)
            print(persons[1].personId)
            print(persons[1].name)
            

//            let linkHrefs = try links.map { try $0.attr("href") }
//            //print(linkHrefs)
//            
//            let linkHrefsGroup = linkHrefs.filter { $0.contains("group")}
//            print(linkHrefsGroup)
        
            
            // Пример: извлечение данных из таблицы
//            let rows = try document.select("tr")
//            for row in rows {
//                let columns = try row.select("td")
//                if columns.count >= 2 {
//                    let title = try columns[0].text()
//                    let link = try columns[1].text()
//                    let item = Item(title: title, link: link)
//                    items.append(item)
//                }
//            }
        } catch {
            print("Ошибка при парсинге HTML: \(error)")
        }
        
        return items
    }
}
