//
//  Articles.swift
//  iOSExercise
//
//  Created by Abdullah Alhaider on 4/23/18.
//  Copyright © 2018 Abdullah Alhaider. All rights reserved.
//

import Foundation

struct Articles : Codable {
    
    private enum CodingKeys: String, CodingKey {
        
        // Customizing some key names
        case articleTitle = "title"
        case website
        case authors
        case date
        case content
        case imageUrl = "image_url"
    }
    
    let articleTitle : String?
    let website : String?
    let authors : String?
    let date : String?
    let content : String?
    let imageUrl : String?

}
