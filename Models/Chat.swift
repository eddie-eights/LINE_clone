

import Foundation


struct Chat: Decodable {
    
    let id: String
    let messages: [Messsage]
}
