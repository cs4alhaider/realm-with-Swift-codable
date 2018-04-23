//
//  Exercise.swift
//  iOSExercise
//
//  Created by Abdullah Alhaider on 4/23/18.
//  Copyright © 2018 Abdullah Alhaider. All rights reserved.
//

import Foundation


struct Exercise: Codable {
    
    private enum CodingKeys: String, CodingKey {
        // Customizing key name
        case exerciseTitle = "title"
        case articles
    }
    
    let exerciseTitle : String?
    let articles : [Articles]?
    
}
