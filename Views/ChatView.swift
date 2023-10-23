
import SwiftUI

struct ChatView: View {
    
    let chat: Chat
    
    @State private var inputVal = ""
    
    // フォーカス状態をTextFieldに関連づける
    @FocusState var textFieldFocused: Bool
    
    // Nav遷移画面を閉じるハンドラーを取得
    @Environment(\.dismiss) private var dismiss
    
    @EnvironmentObject var vm: ChatViewModel
    
    var body: some View {
        VStack(spacing:0){
            // メッセージ表示エリア
            messageArea
            
            // ナビゲーションエリア
                .overlay( navArea, alignment: .top)
            
            // メッセージ入力エリア
            inputArea
        }
    }
}



extension ChatView {
    
    // メッセージ表示エリア
    private var messageArea : some View{
        ScrollViewReader { proxy in
            ScrollView   {
                VStack(spacing: 0) {
                    ForEach(chat.messages){ message in
                        MessageRow(message: message)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 72)
            }
            .background(Color("Background"))
            .onTapGesture {
                textFieldFocused = false
            }
            .onAppear{
                scrollToLast(proxy: proxy)
            }
        }
    }
    
    
    // メッセージ入力エリア
    private var inputArea : some View{
        HStack{
            HStack {
                Image(systemName: "plus")
                Image(systemName: "camera")
                Image(systemName: "photo")
            }
            .font(.title2)
            TextField("Aa", text: $inputVal)
                .padding()
                .background(Color(uiColor: .secondarySystemBackground))
                .clipShape(Capsule())
                .overlay(
                    Image(systemName: "face.smiling")
                        .font(.title2)
                        .padding(.trailing)
                        .foregroundColor(.gray)
                    , alignment: .trailing)
                .onSubmit {
                    sendMessage(message: inputVal)
                }
                .focused($textFieldFocused)
            
            Image(systemName: "mic")
                .font(.title2)
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
        .background(Color(uiColor: .systemBackground))
    }
    
    // ナビゲーションエリア
    private var navArea :some View{
        HStack{
            Button(action: {
                dismiss()
            }, label: {
                Image(systemName: "chevron.backward")
                    .font(.title2)
                    .foregroundColor(.primary)
            })
            
            Text("Title")
                .font(.title2.bold())
            Spacer()
            HStack(spacing:16) {
                Image(systemName: "text.magnifyingglass")
                Image(systemName: "phone")
                Image(systemName: "line.3.horizontal")
            }
            .font(.title2)
            
        }
        .padding()
        .background(Color("Background").opacity(0.9))
    }
    
    // メッセージ投稿処理
    private func sendMessage( message: String){
        if(!inputVal.isEmpty){
            vm.addMessage(chatId: chat.id ,message: message)
            inputVal = ""
        }
    }
    
    // 最後のメッセージまでオートスクロールする処理
    private func scrollToLast(proxy: ScrollViewProxy){
        if let lastMessage =  chat.messages.last {
            proxy.scrollTo( lastMessage.id, anchor: .bottom)
        }
    }
}





//
//#Preview {
//    ChatView()
//}
