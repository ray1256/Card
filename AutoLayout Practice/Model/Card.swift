//
//  Card.swift
//  AutoLayout Practice
//
//  Created by 郭瑋 on 2021/11/23.
//

import Foundation
import UIKit

struct Card{
    let photo:UIImage?
    let company:String
    let position:String?
    let name:String
    let phone:String?
    let email:String?
    
    
    
    init(photo:UIImage?,company:String,position:String?,name:String,phone:String?,email:String?) {
        self.photo = photo
        self.company = company
        self.position = position
        self.name = name
        self.phone = phone
        self.email = email
    }
    
}

struct Favorite:Codable{
    let photo: Data?
    let company:String
    let position:String?
    let name:String
    let phone:String?
    
    init(photo:Data?,company:String,name:String,position:String?,phone:String?){
        self.photo = photo
        self.company = company
        self.position = position
        self.name = name
        self.phone = phone
        
        
    }
}
