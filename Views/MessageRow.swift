

import SwiftUI

struct MessageRow: View {
    
    let message: Message
    
    var body: some View {
        HStack(alignment: .top){
            if(message.user.isCurrentUser){
                Spacer()
                messageState
                messageText
            }else{
                userThum
                messageText
                messageState
                Spacer()
            }
            
        }
        .padding(.bottom)
    }
}

//#Preview {
//    MessageRow()
//        .background(.blue)
//}


extension MessageRow {
    
    private var userThum: some View {
        Image(message.user.image)
            .resizable()
            .frame(width: 48, height: 48)
            .clipShape(Circle())
    }
    
    private var messageText: some View{
        Text(message.text)
            .padding()
            // ダークモードの場合は吹き出し背景をグリーンに変更
            .background(message.user.isCurrentUser ? Color("Bubble") : Color(uiColor: .tertiarySystemBackground))
            // ダークモードのとき自分の投稿は文字色を黒のままに
            .foregroundColor(message.user.isCurrentUser ? .black : .primary )
            .cornerRadius(30)
        
    }
    
    private var messageState: some View{
        VStack(alignment: .trailing){
            Spacer()
            if(message.user.isCurrentUser){
                Text(message.read ? "既読" : "")
            }
            Text(formattedDataString)
        }
        .foregroundColor(.secondary)
        .font(.footnote)
    }
    
    private var formattedDataString:String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let date = formatter.date(from: message.date) else{return ""}
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
    
}
