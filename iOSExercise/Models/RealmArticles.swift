//
//  RealmArticles.swift
//  iOSExercise
//
//  Created by Abdullah Alhaider on 4/24/18.
//  Copyright © 2018 Abdullah Alhaider. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class RealmArticles: Object, Codable {
    
    @objc dynamic var title: String = ""
    @objc dynamic var website: String = ""
    @objc dynamic var authors: String = ""
    @objc dynamic var date: String = ""
    @objc dynamic var content: String = ""
    @objc dynamic var image_url: String = ""
    
    
    override static func primaryKey() -> String? {
        return "title"
    }
    
    
    private enum ArticlesCodingKeys: String, CodingKey {
        
        case title
        case website
        case authors
        case date
        case content
        case image_url
    }
    
    convenience init(title: String, website: String, authors: String, date: String, content: String, image_url: String){
        self.init()
        self.title = title
        self.website = website
        self.authors = authors
        self.date = date
        self.content = content
        self.image_url = image_url
    }
    
    
    convenience required init(form decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ArticlesCodingKeys.self)
        let title = try container.decode(String.self, forKey: .title)
        let website = try container.decode(String.self, forKey: .website)
        let authors = try container.decode(String.self, forKey: .authors)
        let date = try container.decode(String.self, forKey: .date)
        let content = try container.decode(String.self, forKey: .content)
        let image_url = try container.decode(String.self, forKey: .image_url)
        
        self.init(title: title, website: website, authors: authors, date: date, content: content, image_url: image_url)
    }
    
    
    required init() {
        super.init()
    }
    
    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }

    
}
