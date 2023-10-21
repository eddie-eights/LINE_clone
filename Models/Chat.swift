//
//  Chat.swift
//  LineChat
//
//  Created by 福田瑛斗 on 2023/10/15.
//

import Foundation


struct Chat: Decodable {
    
    let id: String
    let messages: [Messsage]
}
