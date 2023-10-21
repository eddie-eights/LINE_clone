//
//  User.swift
//  LineChat
//
//  Created by 福田瑛斗 on 2023/10/15.
//

import Foundation


struct User: Decodable {
    
    let id: String
    let name: String
    let image: String
    
    var isCurrentUser: Bool {
        self.id == "1";
    }
    
}
