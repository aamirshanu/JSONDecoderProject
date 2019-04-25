//
//  File.swift
//  JSONDecoderProject
//
//  Created by mac on 13/04/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation

struct WebsiteDiscription: Decodable {
    
    let name: String?
    let description: String?
    let courses: [Course]? 
}

struct Course: Decodable {
    let name: String?
    let imageUrl: String?
    let number_of_lessons: Int?
    
}
