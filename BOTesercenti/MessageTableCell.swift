import UIKit
import SparkSDK

class MessageTableCell : UITableViewCell {
    var message: Message?
    var isUser: Bool?
    var messageShapeLayer: CAShapeLayer?
    
    var attachedFile: NSMutableData?
    
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
        
        if let _ = message.files{
            if(!(message.files?.isEmpty)!){
                print("found files")
                for file in message.files! {
                    if file.mimeType == "text/html"{
                        
                        var textToAdd = message.text!
                        textToAdd.removeFirst(7)
                        textToAdd.removeLast(4)
                        self.textLabel?.text = "Bot: " + textToAdd
                        
                        sparkSDK?.messages.downloadFile(file, completionHandler: { (result) in
                            
                            if let _ = result.data {
                                
                                var pdfName = message.text!
                                
                                print(result.data!)
                                
                                self.attachedFile = self.convertHTMLtoPDF(path: result.data!.path)
                                
                                
                            }
                            
                        })
                    }
                }
            }
        }
        
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
    
    func convertHTMLtoPDF(path: String) -> NSMutableData {
        
        
        do {
            
            var HTMLContent = try String(contentsOfFile: path)
            
            let printPageRenderer = CustomPrintPageRenderer()
            
            let printFormatter = UIMarkupTextPrintFormatter(markupText: HTMLContent)
            printPageRenderer.addPrintFormatter(printFormatter, startingAtPageAt: 0)
            
            let pdfData = NSMutableData()
            
            UIGraphicsBeginPDFContextToData(pdfData, CGRect.zero, nil)
            
            for i in 0..<printPageRenderer.numberOfPages {
                UIGraphicsBeginPDFPage()
                printPageRenderer.drawPage(at: i, in: UIGraphicsGetPDFContextBounds())
            }
            
            UIGraphicsEndPDFContext()
            
            var pdfFilename = "pdffile.pdf"
            pdfData.write(toFile: pdfFilename, atomically: true)
            
            print("PDF NAME \(pdfFilename)")
            
            //            var itemsToShare = [AnyHashable]()
            //            itemsToShare.append(pdfData)
            //            let controller = UIActivityViewController(activityItems: itemsToShare, applicationActivities: nil)
            //            self.present(controller, animated: true) {() -> Void in }
            
            
            return pdfData
            
        }
            
        catch {print("error")}
        
        return NSMutableData()
        
    }
    

}


