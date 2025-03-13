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
            
//            let link = try document.select("a").first()
//            print(link)
//            let linkHref = try link?.attr("href")
//            print(linkHref)
//            let linkText = try link?.text()
//            print(linkText)
            
            let links = try document.select("a")
            var linksDict = [String:String]()
            for link in links {
                
                let id = try link.attr("href")
                let text = try link.text()
                
                linksDict.updateValue(text, forKey: id)

            
            }
            
            print(linksDict)
            
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
