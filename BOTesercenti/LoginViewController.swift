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
        let authenticator = OAuthAuthenticator(clientId: clientId, clientSecret: clientSecret, scope: scope, redirectUri: redirectUri)
        let spark = Spark(authenticator: authenticator)
        
        print("authorizing")
        
        authenticator.authorize(parentViewController: self) { success in
                
            if !success {
                    
                print("User not authorized")
                    
            } else {
                    
                print("User authorized.")
                
                spark.people.getMe(completionHandler: { (response) in
                    username = response.result.data!.displayName!
                    userEmail = response.result.data!.emails?.first!
                    userProfileId = response.result.data!.id
                    
                    let homeViewController = self.storyboard?.instantiateViewController(withIdentifier: "homeViewController") as! HomeViewController
                    sparkSDK = spark
                    rootController = homeViewController
                    (UIApplication.shared.delegate as! AppDelegate).registerNotificationInfo(application: UIApplication.shared)
                    self.navigationController?.pushViewController(homeViewController, animated: true)
                    
                    
//                    })
                
                })
            }
        }
    }
}

