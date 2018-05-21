import UIKit
import SparkSDK

class MessageTableCell : UITableViewCell {
    var message: Message
    var isUser: Bool
    
    init(message: Message){
        
        self.message = message
        self.isUser = (message.personId! == userProfileId!) || (message.personEmail == userEmail?.toString())
        super.init(style: .default, reuseIdentifier: "messageCell")
        self.textLabel?.text = isUser ? "tu: " + message.text! : message.text
        self.backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
