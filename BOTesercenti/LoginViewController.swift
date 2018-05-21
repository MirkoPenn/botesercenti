//
//  ViewController.swift
//  SparkDemoApp
//
//  Created by Mirko Pennone on 18/05/18.
//  Copyright © 2018 com.example. All rights reserved.
//

import UIKit
import SparkSDK

class LoginViewController: UIViewController {
    
    @IBOutlet weak var botAnimationView: AnimationView!
    @IBOutlet weak var chatButton: UIButton!
    
    @IBOutlet weak var historyButton: UIButton!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var documentComposer: DocumentComposer!
    var HTMLContent: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]

        botAnimationView.add_2Animation()

          //html
//        documentComposer = DocumentComposer()
//        if let invoiceHTML = documentComposer.renderHTML2(){
//
//            HTMLContent = invoiceHTML
//            let pdf = convertHTMLtoPDF(html: HTMLContent)
//
//            var itemsToShare = [AnyHashable]()
//            itemsToShare.append(pdf)
//            let controller = UIActivityViewController(activityItems: itemsToShare, applicationActivities: nil)
//            present(controller, animated: true) {() -> Void in }
//        }
    }
    
    func convertHTMLtoPDF(html: String) -> NSMutableData {
        
        
        do {
            
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
    
    override func viewWillAppear(_ animated: Bool) {
        chatButton.isHidden = false
        historyButton.isHidden = false
        activityIndicator.isHidden = true
        self.navigationController?.navigationBar.isHidden = true
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func loginAndStartRoom(sender: AnyObject) {
        
        //        let authenticator = OAuthAuthenticator(clientId: clientId, clientSecret: clientSecret, scope: scope, redirectUri: redirectUri)
        //        let spark = Spark(authenticator: authenticator)
        //        authenticator.authorize(parentViewController: self) { success in
        //
        //            if !success {
        //
        //                print("User not authorized")
        //
        //            } else {
        //
        //                print("User authorized.")
        //
        //
        //            }
        //        }
        
        chatButton.isHidden = true
        historyButton.isHidden = true
        activityIndicator.isHidden = false
        
        
        let jwtAuthStrategy = JWTAuthenticator()
        jwtAuthStrategy.authorizedWith(jwt: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxIiwibmFtZSI6IuKAnEFwcGxlQWNhZCIsImlzcyI6IlkybHpZMjl6Y0dGeWF6b3ZMM1Z6TDA5U1IwRk9TVnBCVkVsUFRpODBNV0kwTkRKbVppMHdZVEU1TFRSaE5HSXRPREF5TWkxak1tUTNZbVUwT1dObE9ESSIsImV4cCI6MTUyNzAwMTgzM30.qRqkEc16Z9hi4bEcgkNWKLrTLBiXxeUHbfQvrROe9Go")
        if jwtAuthStrategy.authorized == true {
            /* JWT Login success process codes here....*/
            sparkSDK = Spark(authenticator: jwtAuthStrategy)
            sparkSDK?.logger = KSLogger() //Register a console logger into SDK
            loginSuccessProcess()
        } else {
            /* JWT Login failure process codes here....*/
            print("Error with JWT")
        }
        
        
    }
    
    private func loginSuccessProcess(){
        
        print("authorizing")
        
        sparkSDK?.people.getMe(completionHandler: { (response) in
            username = response.result.data!.displayName ?? "guest"
            userEmail = response.result.data!.emails?.first!
            userProfileId = response.result.data!.id
            
            //            self.startRoom()
            
        })
    }
    
    //    private func startRoom(){
    //
    //        let chatViewController = self.storyboard?.instantiateViewController(withIdentifier: "chatViewController") as! ChatViewController
    //        rootController = chatViewController
    //        (UIApplication.shared.delegate as! AppDelegate).registerNotificationInfo(application: UIApplication.shared)
    //        self.navigationController?.pushViewController(chatViewController, animated: true)
    //
    //    }
}

