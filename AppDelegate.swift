//
//  AppDelegate.swift
//  Save It Right
//
//  Created by Shouq Turki Bin Tuwaym on 20/02/2023.
//

import UIKit

//@main
class AppDelegate: NSObject, UIApplicationDelegate {
    func applicationDidBecomeActive(_ application: UIApplication) {
        print("testing whatever")
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        UIApplication.shared.applicationIconBadgeNumber = 0
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
            // Override point for customization after application launch.
            
//            let launchedBefore = UserDefaults.standard.bool(forKey: "completeOnBoarding")
//            
//    //        UserDefaults.standard.set(true, forKey: "launchedBefore")
//            
//            if launchedBefore  {
//                print("Not first launch.")
//            }
//                
//            else {
//                print("First launch, setting UserDefault.")
//                
//                UserDefaults.standard.set(true, forKey: "launchedBefore")
//            }
            
            return true
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // Handle the remote notification
        // This method will be called when the app receives a remote notification
        // You can use the userInfo dictionary to access the content of the notification
        
        // Call the completion handler when you have finished processing the notification
        completionHandler(.newData) // or .noData or .failed
    }
    
    func application(_ application: UIApplication, didReceive url: URL, fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // Handle the download task
        // This method will be called when the app receives a background download task
        
        // Use the url parameter to access the downloaded file
        
        // Call the completion handler when you have finished processing the download task
        completionHandler(.newData) // or .noData or .failed
    }
}
