

import Foundation


struct Chat: Decodable, Identifiable {
    
    let id: String
    let messages: [Messsage]
    
    var recentMessageText: String {
        guard let lastMessage = self.messages.last else { return "" }
        return lastMessage.text
    }
    
    var recentMessageDateString: String {
        guard let lastMessage = self.messages.last else { return "" }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let date = formatter.date(from: lastMessage.date) else{return ""}
        formatter.dateFormat = "MM/dd"
        return formatter.string(from: date)
    }
    
}
