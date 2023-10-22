
import SwiftUI

struct ChatView: View {
    
    @State private var inputVal = ""
    
    // フォーカス状態をTextFieldに関連づける
    @FocusState var textFieldFocused: Bool
    
    @ObservedObject var vm: ChatViewModel = ChatViewModel()
    
    var body: some View {
        VStack(spacing:0){
            // チャットエリア
            messageArea
            
            // ナビゲーションエリア
                .overlay( navArea, alignment: .top)
            
            // テキスト入力エリア
            inputArea
        }
    }
}

#Preview {
    ChatView()
}


extension ChatView{
    
    private var messageArea : some View{
        ScrollView{
            VStack(spacing: 0) {
                ForEach(vm.messages){ message in
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
    }
    
    
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
    
    
    private var navArea :some View{
        HStack{
            Image(systemName: "chevron.backward")
                .font(.title2)
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
    
    private func sendMessage(message: String){
        if(!inputVal.isEmpty){
            vm.addMessage(message: message)
            inputVal = ""
        }
    }
}
