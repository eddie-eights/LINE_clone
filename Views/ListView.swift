
import SwiftUI

struct ListView: View {
    
    @ObservedObject var vm: ChatViewModel = ChatViewModel()
    
    var body: some View {
        
        NavigationView {
            VStack{
                // ヘッダー
                header
                
                // チャットリスト
                list
                
            }
            .padding(.horizontal)
        }
    }
}

extension ListView {
    
    var header: some View {
        HStack{
            Text("トーク")
                .font(.title2.bold())
            Spacer()
            HStack(spacing: 16){
                Image(systemName: "text.badge.checkmark")
                Image(systemName: "square")
                Image(systemName: "ellipsis.bubble")
            }
        }
        
        
    }
    var list: some View {
        ScrollView {
            ForEach(vm.chatData){ chat in
                NavigationLink {
                    ChatView(chat: chat)
                        .environmentObject(vm)
                        .toolbar(.hidden)
                } label: {
                    listRow(chat: chat)
                        .foregroundColor(.primary)
                }
                
                
            }
        }
    }
    
    // 引数を受け取れるように関数コンポーネントに修正
    // var listRow: some View {
    private func listRow(chat: Chat) -> some View {
        HStack{
            let images = vm.getImages(messages: chat.messages)
            HStack(spacing: -32){
                ForEach(images, id: \.self){ image in
                    
                    Image(image)
                        .resizable()
                        .frame(width: 48, height: 48)
                        .clipShape(Circle())
                        .background(
                            Circle()
                                .foregroundColor(Color(uiColor: .systemBackground))
                                .frame(width: 52, height: 52)
                        )
                }
            }
            VStack(alignment: .leading){
                Text(vm.getTitle(messages: chat.messages))
                    .lineLimit(1)
                
                Text(chat.recentMessageText)
                    .lineLimit(1)
                    .font(.footnote)
                    .foregroundColor(Color(uiColor: .secondaryLabel))
            }
            Spacer()
            Text(chat.recentMessageDateString)
                .font(.caption)
                .foregroundColor(Color(uiColor: .secondaryLabel))
        }
        .padding(.vertical, 8)
    }
}


#Preview {
    ListView()
}

