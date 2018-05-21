//
//  HomeViewController.swift
//  SparkDemoApp
//
//  Created by Mirko Pennone on 18/05/18.
//  Copyright © 2018 com.example. All rights reserved.
//

import UIKit
import SparkSDK
import Alamofire
import os.log

class ChatViewController: UIViewController, UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell")!
        let cell = MessageTableCell(message:messageList[indexPath.row])
        return cell
    }
    
    @IBOutlet weak var tableview: UITableView!
    
    var userId: String?
    
    var roomId: String?
    
    var messageList: [Message] = []
    
    var hasLogged: Bool = false
    
    
    @IBOutlet weak var welcomeLabel: UILabel!
    
    @IBOutlet weak var chatView: UIView!
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Call", style: .plain, target: self, action: #selector(self.callOperator))

        chatView.isHidden = true
        tableview.delegate = self
        tableview.dataSource = self
        
        textField.delegate = self
        
        sparkSDK?.phone.register({ (error) in
            if error == nil{
                print("Phone registered")
                self.chatView.isHidden = false
                self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Call", style: .plain, target: self, action: #selector(self.callOperator))
                self.activityIndicator.isHidden = true
                sparkSDK?.messages.onEvent = { event in
                    switch event{
                    case .messageReceived(let message):
                        //                        print("\(message.personEmail): \(message.text)")
                        //                        self.messageLabel.text?.append("\nBot: \(message.text ?? "ERROR")")
                        DispatchQueue.main.async{
                            
                            if let _ = message.files{
                                
                                if(!(message.files?.isEmpty)!){
                                    
                                    print("found files")
                                    
                                    for file in message.files! {
                                        
                                        print(file)
                                        
                                        if file.mimeType == "text/html"{
                                            print("found an html")
                                            
                                            sparkSDK?.messages.downloadFile(file, completionHandler: { (result) in
                                                
                                                if let _ = result.data {
                                                    
                                                    var pdfName = message.text!
                                                    
                                                    print(result.data!)
                                                 
                                                    self.messageList.append(message)
                                                    self.tableview.reloadData()
                                                    
                                                    var convertedpdf = self.convertHTMLtoPDF(path: result.data!.path)
                                                    
                                                    pdfName.removeLast(4)
                                                    
                                                    pdfs.append(PDF(name: pdfName, size: String(ByteCountFormatter().string(fromByteCount: Int64(convertedpdf.length))), date: Date(), data: convertedpdf)!)
                                                    
                                                    (UIApplication.shared.delegate as! AppDelegate).savePDF()
                                                     
                                                    
                                                }
                                                
                                            })
                                        } else {
                                            
                                            self.messageList.append(message)
                                            self.tableview.reloadData()
                                            
                                        }
                                        
                                        
                                    }
                                    
                                }else {
                                    
                                    self.messageList.append(message)
                                    self.tableview.reloadData()
                                    
                                }
                            } else {
                                
                                self.messageList.append(message)
                                self.tableview.reloadData()
                                
                            }
                            
                        }
                        //
                        break
                    case .messageDeleted(let _):
                        break
                    }
                }
                
            }
        })
        
        // Do any additional setup after loading the view.
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func callOperator(){
        if(hasLogged){
            performSegue(withIdentifier: "callOperator", sender: nil)
        }
    }
    
    
    @IBAction func sendMessageButton(_ sender: Any) {
        //self.messageLabel.text?.append("\nYou: \(textField.text ?? "ERROR")")
        sparkSDK!.messages.post(personEmail: EmailAddress.fromString("JarvisiOS@sparkbot.io")!, text: textField.text ?? "") { response in
            switch response.result {
            case .success(let message):
                print("Sent! Message: \(message)")
                self.roomId = message.roomId!
                DispatchQueue.main.async {
                self.messageList.append(message)
                self.tableview.reloadData()
                }
                break
//                print("\(message.personEmail): \(message.text)")
            // ...
            case .failure(let error):
                print("Error: \(error)")
            }
        }
        self.textField.text = ""
    }
    
    
    func registerSparkWebhook(completionHandler: ((Bool) -> Void)?) {

        print("Checking webhook")
        
        if let voipToken = UserDefaults.standard.string(forKey: "com.appleacademy.botesercenti.data.device_voip_token"),
            let msgToken = UserDefaults.standard.string(forKey: "com.appleacademy.botesercenti.data.device_msg_token") {


            let threahGroup = DispatchGroup()

            /*
             Check if MSG web hook is registered for user
             */
            
            DispatchQueue.global().async(group: threahGroup, execute: DispatchWorkItem(block: {
                if(!isWebHookCreated){
                    sparkSDK?.webhooks.list(completionHandler: { (response: ServiceResponse<[Webhook]>) in
                        switch response.result {
                        case .success(let value):
                            for webhook in value{
                                print(webhook)
                                if(webhook.resource == "messages"){
                                    isWebHookCreated = true
                                    print("Webhook was already created.")
                                    return
                                }
                            }
                            self.createNewWebHook()
                            break
                        case .failure:
                            self.createNewWebHook()
                            break
                        }
                    })
                }
            }))

            /*
             Register notificaiton info into web hook server
             */
            DispatchQueue.global().async(group: threahGroup, execute: DispatchWorkItem(block: {
                if(!isRegisterdOnWebHookServer){
                    /*
                     register device notification info on webhook server
                     */
                    let webHookServiceParamater: Parameters = [
                        "email": userEmail!.toString(),
                        "voipToken": voipToken,
                        "msgToken": msgToken,
                        "personId": userProfileId!
                    ]

                    Alamofire.request("https://botesercenti.herokuapp.com/register", method: .post, parameters: webHookServiceParamater, encoding: JSONEncoding.default).validate().response { res in
                        completionHandler?(true)
                        if(res.error == nil){
                            print("Webhookserver Register success")
                            isRegisterdOnWebHookServer = true

                        }
                    }
                }
            }))
            threahGroup.notify(queue: DispatchQueue.global(), execute: {
                DispatchQueue.main.async {

                }
            })
        }
        else {
            completionHandler?(false)
        }
    }

    
    func createNewWebHook(){
        /* create webhook for notification reception */
        let webHookName = username! + "-MSG-WebHook"
        let targetUrl = redirectUrl
        //                    let filter = Constants.Webhook.filter
        /*
         Scope of notification, should one of resource below
         [all, calls, rooms, messages, memberships, callMemberships]
         */
        let resource = "messages"
        /*
         events of notification, should one of resource below
         [created, all, updated, deleted]
         */
        let event = "all"
        print("Creating webhook... \(webHookName), \(targetUrl)")
        sparkSDK?.webhooks.create(name: webHookName, targetUrl: targetUrl, resource: resource, event: event, completionHandler: { (response: ServiceResponse<Webhook>) in
            switch response.result{

            case .success(let webhook):
                webhookId = webhook.id!
                print("Created webhook with ID: \(webhookId)")
                break
            case .failure(let error):
                print(error.localizedDescription)
                break
            }

        })
    }

    func receviMessageNotification(fromEmail: String, title: String){
        
        print("\(fromEmail): \(title)")

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true) //This will hide the keyboard
    }

///////////



//    @IBAction func sendMessage(_ sender: Any) {
//        sparkSDK!.messages.post(personEmail: EmailAddress.fromString("JarvisiOS@sparkbot.io")!, text: "tattaaaaaaaa") { response in
//            switch response.result {
//            case .success(let message):
//                print("Sent! Message: \(message)")
//                self.roomId = message.roomId!
//            // ...
//            case .failure(let error):
//                print("Error: \(error)")
//            }
//        }
//    }
//
//
//    @IBAction func receiveMessage(_ sender: Any) {
//
//
//
//        //        sparkSDK!.people.list(email: EmailAddress.fromString("JarvisiOS@sparkbot.io")!, displayName: nil, max: nil, queue: DispatchQueue.main, completionHandler: { response in
//        //
//        //            for person in response.result.data!{
//        //                print(person.id)
//        //            }
//        //
//        //        })
//        //
//        if let _ = roomId {
//
//
//            //            sparkSDK!.messages.list(roomId: roomId, completionHandler: { (response) in
//            //
//            //
//            //                for message in response.result.data!{
//            //                    print("\(message.personEmail!.toString()): \(message.text!)")
//            //                }
//            //
//            //
//            //            })
//
//
//
//
//        } else {
//
//            print("Send a message before receiving")
//        }
//
//
//    }
//
//@   IBAction func createRoom(_ sender: Any) {
//
//
//        sparkSDK!.rooms.create(title: "Assistenza") { (response) in
//
//
//            sparkSDK!.memberships.create(roomId: response.result.data!.id!, personEmail: EmailAddress.fromString("JarvisiOS@sparkbot.io")!, completionHandler: { (response) in
//
//                print(response.result.data!.roomId!)
//
//                sparkSDK!.webhooks.create(name: "Message received", targetUrl: "", resource: "messages", event: "created", filter: "") { res in
//                    switch res.result {
//                    case .success(let webhook): break
//
//                        // perform positive action
//
//                    case .failure(let error): break
//                        // perform negative action
//                    }
//                }
//
//            })
//        }
//
//
//    }
}
