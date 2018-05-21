//
//  AppDelegate.swift
//  SparkDemoApp
//
//  Created by Mirko Pennone on 18/05/18.
//  Copyright © 2018 com.example. All rights reserved.
//

import UIKit
import SparkSDK
import PushKit
import UserNotifications
import os.log
var sparkSDK: Spark?


let clientId = "C60bf884e885ab74370102995e932f073d0c98ce2ff05fe453a203d1f677aeefd"
let clientSecret = "1a0dd38ae30a990ee1c5ad0618c6db37451d1d413d56d52da48cfeb3659acf50"
let scope = "spark:all"
let redirectUri = "SparkDemoApp://response"
let redirectUrl = "https://botesercenti.herokuapp.com/webhook"


var username: String?
var userEmail: EmailAddress?
var userProfileId: String?
var loginType: UserLoginType = .None

var webhookId: String?
var isRegisterdOnWebHookServer: Bool = false
var isWebHookCreated: Bool = false

var pdfs = [PDF]()



enum UserLoginType : Int {
    case None // not Login
    case User // Login as OAuthUser
    case Guest // Login as Guest
}




var rootController: ChatViewController?


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, PKPushRegistryDelegate{
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        UIApplication.shared.statusBarStyle = .lightContent

        
        let navStyles = UINavigationBar.appearance()
        // This will set the color of the text for the back buttons.
        navStyles.tintColor = .white
        // This will set the background color for navBar
        navStyles.barTintColor = UIColor(red:0.01, green:0.54, blue:0.34, alpha:1.0)
        
        return true
        
    }
    
    func registerNotificationInfo(application: UIApplication){
        
        let pr = PKPushRegistry(queue: DispatchQueue.main)
        pr.delegate = self
        pr.desiredPushTypes = [PKPushType.voIP]
        UNUserNotificationCenter.current().requestAuthorization(options:[.alert, .sound, .badge]) { (granted: Bool, error: Error?) in
            if (error != nil) {
                print("Failed to request authorization")
                return
            }
            if granted {
                DispatchQueue.main.async {
                    
                    print("Registering notification info...")
                    application.registerForRemoteNotifications()
                    
                }
            } else {
                print("The user refused the push notification")
            }
        }
        
    }
    
    // Get device token for message push notification
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let hex = deviceToken.map( {String(format: "%02x", $0) }).joined(separator: "")
        /* saving message noti certificate date on local UserDefualt */
        
        print("Registered with token: \(hex)")
        UserDefaults.standard.set(hex, forKey: "com.appleacademy.botesercenti.data.device_msg_token")
        rootController?.registerSparkWebhook(completionHandler: nil)
    }
    
    
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register to APNs: \(error)")
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        /* first receive message notification */
        let dict = userInfo["aps"] as? Dictionary<String, AnyObject>
        let alert = dict?["alert"] as? Dictionary<String, AnyObject>
        let email = alert?["body"] as? String
        let title = alert?["title"] as? String
        
        print("received")
        
        let state = UIApplication.shared.applicationState
        //        if state != .active {
        //            if(User.loadUserFromLocal()){
        //                if let localGroup = User.CurrentUser.getSingleGroupWithContactEmail(email: email!){
        //                    localGroup.unReadedCount += 1
        //                }
        //            }
        //        }else{
        //            if(User.CurrentUser.loginType != .None){
        //                if let localGroup = User.CurrentUser.getSingleGroupWithContactEmail(email: email!){
        //                    localGroup.unReadedCount += 1
        //                }
        //            }
        //        }
        
        if(title == "New Message"){
            if let home = rootController, let email = email {
                if email != userEmail!.toString(){
                    home.receviMessageNotification(fromEmail: email, title: title!)
                }
            }
        }
    }
    
    
    // Get device token for voip push notification
    func pushRegistry(_ registry: PKPushRegistry, didUpdate credentials: PKPushCredentials, for type: PKPushType) {
        let hex = credentials.token.map( {String(format: "%02x", $0) }).joined(separator: "")
        /* saving voip noti certificate date on local UserDefualt */
        UserDefaults.standard.set(hex, forKey: "com.appleacademy.botesercenti.data.device_voip_token")
        
        rootController?.registerSparkWebhook(completionHandler: nil)
    }
    
    func pushRegistry(_ registry: PKPushRegistry, didReceiveIncomingPushWith payload: PKPushPayload, for: PKPushType) {
        
        /* first receive voip/call notification */
        print("received call")
        let dict =  payload.dictionaryPayload["aps"] as? Dictionary<String, AnyObject>
        let alert = dict?["alert"] as? Dictionary<String, AnyObject>
        let idStr = alert?["body"] as? String
        let state = UIApplication.shared.applicationState
        guard let home = rootController, let id = idStr else{return}
        
    }
    
    
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    public func savePDF() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(pdfs, toFile: PDF.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("PDF successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save pdf...", log: OSLog.default, type: .error)
        }
    }
    
    public func loadPDF() -> [PDF]?  {
        return NSKeyedUnarchiver.unarchiveObject(withFile: PDF.ArchiveURL.path) as? [PDF]
    }
    
    
}
