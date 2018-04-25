//
//  RealmFeeds.swift
//  iOSExercise
//
//  Created by Abdullah Alhaider on 4/24/18.
//  Copyright © 2018 Abdullah Alhaider. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class RealmFeeds: Object, Decodable {
    
    @objc dynamic var title: String = ""
    var articles = List<RealmArticles>()
    
    override static func primaryKey() -> String? {
        return "title"
    }
    
    private enum feedCodingKeys: String, CodingKey {
        // Customizing key name
        case title
        case articles
    }
    
    convenience init(title: String, articles: List<RealmArticles>){
        self.init()
        self.title = title
        self.articles = articles
    }
    
    convenience required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: feedCodingKeys.self)
        let title = try container.decode(String.self, forKey: .title)
        let articlesArray = try container.decode([RealmArticles].self, forKey: .articles)
        let articlesList = List<RealmArticles>()
        articlesList.append(objectsIn: articlesArray)
        self.init(title: title, articles: articlesList)
        
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
