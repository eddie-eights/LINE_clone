
import SwiftUI

struct ListView: View {
    var body: some View {
        
        NavigationView {
            VStack{
                
                header
                
                list
                
            }
            .padding(.horizontal)
        }
    }
}

extension ListView {
    
    var header: some View {
        HStack{
            Text("タイトル")
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
            ForEach(0..<5){ _ in
                NavigationLink {
                    ChatView()
                        .toolbar(.hidden)
                } label: {
                    listRow
                        .foregroundColor(.primary)
                }

              
            }
        }
    }
    
    var listRow: some View {
        HStack{
            Image("user01")
                .resizable()
                .frame(width: 48, height: 48)
                .clipShape(Circle())
            VStack(alignment: .leading){
                Text("名前")
                Text("最新のメッセージ")
                    .font(.footnote)
                    .foregroundColor(Color(uiColor: .secondaryLabel))
            }
            Spacer()
            Text("12/24")
                .font(.caption)
                .foregroundColor(Color(uiColor: .secondaryLabel))
            
            
        }
    }
    
}


#Preview {
    ListView()
}
