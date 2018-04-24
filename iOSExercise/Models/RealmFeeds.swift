//
//  RealmFeeds.swift
//  iOSExercise
//
//  Created by Abdullah Alhaider on 4/24/18.
//  Copyright © 2018 Abdullah Alhaider. All rights reserved.
//

import Foundation
import RealmSwift

class Feeds: Object {
    
    @objc dynamic var feedTitle: String = ""
    @objc dynamic var feedTitle1: String = ""
    @objc dynamic var feedTitle2: String = ""
    @objc dynamic var feedTitle3: String = ""
    @objc dynamic var feedTitle4: String = ""
    @objc dynamic var feedTitle5: String = ""
    
}

extension Feeds {
    
    func writeToRealm() {
        try! uiRealm.write {
            uiRealm.add(self)
        }
    }
}
