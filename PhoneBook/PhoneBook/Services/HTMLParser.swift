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
                    
                    //Получаю ID группы для Person
                    groupId = String(groupId.dropFirst(9))
                    let personId = try tag.attr("id")
                    
                    //Получаю должность для Person
                    //Здесь я получил должность с именем. Чтобы оставить только должность, я делаю должность с маленькой буквы и убирают весь текст, который начинается с больщой буквы (Имя)
                    var jobTitle = try tag.select("td:nth-child(2)").text()
                    //Здесь делаю должность с маленькой буквы
                    jobTitle = jobTitle.prefix(1).lowercased() + jobTitle.dropFirst()
                    
                    //Здесь убираю часть строки с именем
                    if let range = jobTitle.range(of: "[А-ЯA-Z]", options: .regularExpression) {
                        jobTitle = String(jobTitle[..<range.lowerBound])
                        
                    }
                    
                    jobTitle = jobTitle.prefix(1).uppercased() + jobTitle.dropFirst()
                    
                    let personName = try tag.select("strong").text()
                    let workPhone = try tag.select("td:nth-child(3)").text()
                    let cityPhone = try tag.select("td:nth-child(4)").text()
                    let buildingRoom = try tag.select("td:nth-child(5)").text()
                    
                    

                    let person = Person(groupId: groupId, personId: personId, jobTitle: jobTitle, personName: personName, workPhone: workPhone, cityPhone: cityPhone, buildingRoom: buildingRoom)
                    persons.append(person)
                }
                
        
            }

            print(persons.count)
            print(persons[10].groupId)
            print(persons[10].personId)
            print(persons[10].jobTitle)
            print(persons[10].personName)
            print(persons[10].workPhone)
            print(persons[10].cityPhone)
            print(persons[10].buildingRoom)
        
            

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
