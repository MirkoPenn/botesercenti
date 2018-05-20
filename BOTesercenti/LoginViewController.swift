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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func loginWithSpark(sender: AnyObject) {
        
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
            username = response.result.data!.displayName!
            userEmail = response.result.data!.emails?.first!
            userProfileId = response.result.data!.id
            
            let homeViewController = self.storyboard?.instantiateViewController(withIdentifier: "homeViewController") as! HomeViewController
            rootController = homeViewController
            (UIApplication.shared.delegate as! AppDelegate).registerNotificationInfo(application: UIApplication.shared)
            self.navigationController?.pushViewController(homeViewController, animated: true)
            
            
        })
    }
}

