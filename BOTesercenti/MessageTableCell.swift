import UIKit
import SparkSDK

class MessageTableCell : UITableViewCell {
    var message: Message?
    var isUser: Bool?
    var messageShapeLayer: CAShapeLayer?
    
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var cellLabel: UILabel!
   
    init(message: Message) {
        
        self.message = message
        self.isUser = (message.personId! == userProfileId!) || (message.personEmail == userEmail?.toString())
        super.init(style: .default, reuseIdentifier: "messageCell")
        self.selectionStyle = .none
        self.textLabel?.text = isUser! ? "Tu: " + message.text! : "Bot: " + message.text!
        self.backgroundColor = UIColor.clear
        self.contentView.layer.cornerRadius = 20
        self.contentView.clipsToBounds = true
        
        self.contentView.backgroundColor = isUser! ? UIColor(red:0.39, green:0.39, blue:0.39, alpha:1.0) : UIColor(red:0.01, green:0.54, blue:0.34, alpha:1.0)
        
        self.textLabel?.numberOfLines = 0
        self.textLabel?.textColor = UIColor.white
       
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let f = contentView.frame
        let fr = UIEdgeInsetsInsetRect(f, UIEdgeInsetsMake(0, 0, 10, 0))
        contentView.frame = fr
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}


