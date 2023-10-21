//
//  Messsage.swift
//  LineChat
//
//  Created by 福田瑛斗 on 2023/10/15.
//

import Foundation


struct Messsage: Decodable, Identifiable {
    
    let id: String
    let text: String
    let user: User
    let date: String
    let read: Bool
    
}
