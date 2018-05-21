import UIKit
import SparkSDK

class MessageTableCell : UITableViewCell {
    var message: Message?
    var isUser: Bool?
    var messageShapeLayer: CAShapeLayer?
    var contentLabel: UILabel?
    
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var cellLabel: UILabel!
   
    func setMessage (message: Message) {
        
        self.message = message
        self.isUser = (message.personId! == userProfileId!) || (message.personEmail == userEmail?.toString())
//        super.init(style: .default, reuseIdentifier: "messageCell")
        
        self.cellLabel.text = isUser! ? "tu: " + message.text! : message.text
        self.backgroundColor = UIColor.clear
        self.cellView.frame.size = CGSize(width: UIScreen.main.bounds.width/2, height:cellView.frame.size.height)
        self.cellView.layer.cornerRadius = 20
        self.cellView.clipsToBounds = true
        self.cellView.backgroundColor = UIColor.green
        
        self.cellLabel.frame.size.width = UIScreen.main.bounds.width/2 - 10
        self.cellLabel.numberOfLines = 0
       
        
    }
    

}


