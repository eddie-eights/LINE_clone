

import Foundation


struct Messsage: Decodable, Identifiable {
    
    let id: String
    let text: String
    let user: User
    let date: String
    let read: Bool
    
}
