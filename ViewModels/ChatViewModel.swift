
import Foundation


class ChatViewModel: ObservableObject {
    
    @Published var chatData: [Chat] = []
    
    // イニシャライザー
    init() {
        chatData = fetchChatData()
    }
    
    // chatデータを取得する処理
    private func fetchChatData() -> [Chat] {
        let filename = "chatData.json"
        let data: Data
        
        // ファイルパスを取得
        guard
            let filePath = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("\(filename)が見つかりませんでした。")
        }
        
        // データを取得
        do {
            data = try Data(contentsOf: filePath)
        } catch {
            fatalError("\(filename)の取得に失敗しました。")
        }
        
        // 取得したJSONデータをChat型にデコード
        do {
            return try JSONDecoder().decode([Chat].self, from: data)
        } catch {
            fatalError("\(filename)を\(Chat.self)に変換できませんでした。")
        }
        
    }
    
    // 入力されたメッセージをchat.messagesに追加する処理
    func addMessage(chatId: String, message: String){
        // guard let の場合は クロージャー式は使えずwhereの引数として処理を書く
        guard
            let index = chatData.firstIndex( where: { chat in
                chat.id == chatId
            })
        else {
            return
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let formattedDateDtring = formatter.string(from: Date())
        
        let newMessage = Message(
            id: UUID().uuidString,
            text: message,
            user: User.currentUser,
            date:formattedDateDtring,
            read: false)
        
        chatData[index].messages.append(newMessage)
    }
    
    // チャットリストのタイトルを生成
    func getTitle(messages: [Message]) -> String {
        var title = ""
        
        let names = getMembers(messages: messages, type: .name)
        
        for name in names{
            title += title.isEmpty ? "\(name)" : ", \(name)"
        }
        
        return title
    }
    
    // チャットリストのユーザーアイコンを取得
    func getImages(messages: [Message])-> [String] {
        return getMembers(messages: messages, type: .image)
    }
    
    
    private func getMembers(messages: [Message], type: ValueType ) -> [String] {
        var result: [String] = []
        var uniqueIds: [String] = []
        
        for message in messages {
            // id で重複を排除
            let id = message.user.id
            
            // 重複と自分のidを排除
            if id == User.currentUser.id{ continue }
            if uniqueIds.contains(id) { continue }
            
            uniqueIds.append(id)
            
            switch type {
            case .name:
                result.append(message.user.name)
            case .image:
                result.append(message.user.image)
            }
        }
        
        return result
    }
    
    enum ValueType {
        case name
        case image
    }
    
    
}
