//
//  ChatViewModel.swift
//  LineChat
//
//  Created by 福田瑛斗 on 2023/10/16.
//

import Foundation


class ChatViewModel: ObservableObject {
    
    
    var chatData: [Chat] = []
    @Published var messages: [Messsage] = []
    
    init() {
        chatData = fetchChatData()
        messages = chatData[0].messages
        
    }
    
    private func fetchChatData() -> [Chat] {
        let filename = "chatData.json"
        let data: Data
        
        // ファイルパスを取得
        guard
            let filePath = Bundle.main.url(forResource: filename, withExtension: nil)
        else{
            fatalError("\(filename)が見つかりませんでした。")
        }
        
        // データを取得
        do {
            data = try Data(contentsOf: filePath)
        } catch{
            fatalError("\(filename)の取得に失敗しました。")
        }
        
        // 取得したJSONデータをChat型にデコード
        do {
            return try JSONDecoder().decode([Chat].self, from: data)
        }catch {
            fatalError("\(filename)を\(Chat.self)に変換できませんでした。")
        }
        
    }
    
    func addMessage(message: String){
        let newMessage = Messsage(id: UUID().uuidString, text: message, user: User.currentUser, date: Date().description, read: false)
        messages.append(newMessage)
    
    }
    
}
