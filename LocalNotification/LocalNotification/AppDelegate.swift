//
//  AppDelegate.swift
//  LocalNotification
//
//  Created by qiuweniOS on 2018/11/28.
//  Copyright © 2018 AndyCuiYTT. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            center.delegate = self
            center.requestAuthorization(options: [.alert, .badge, .sound]) { (flag, error) in
                if flag {
                    print("success")
                } else {
                    print("faile")
                }
            }
        } else if #available(iOS 8.0, *) {
            
            let category = UIMutableUserNotificationCategory()
//            category.actions(for: <#T##UIUserNotificationActionContext#>)
            
            let oneMinutesAfter = UIMutableUserNotificationAction()
            oneMinutesAfter.title = "一分钟后"
            oneMinutesAfter.identifier = "oneMinutesAfter"
            oneMinutesAfter.activationMode = .background // 不进入程序
            oneMinutesAfter.isAuthenticationRequired = true // 需要解锁才处理
//            oneMinutesAfter.
            let twoMinutesAfter = UIMutableUserNotificationAction()
            twoMinutesAfter.title = "二分钟后"
            twoMinutesAfter.identifier = "oneMinutesAfter"
            twoMinutesAfter.activationMode = .foreground // 点击进入程序
            category.setActions([oneMinutesAfter, twoMinutesAfter], for: UIUserNotificationActionContext.minimal)
            category.identifier = "after"
            //UIUserNotificationCategory() //UNNotificationAction(identifier: "oneMinutesAfter", title: "一分钟后提醒", options: UNNotificationActionOptions.destructive)
//
//            let twoMinutesAfter = UNNotificationAction(identifier: "twoMinutesAfter", title: "二分钟后提醒", options: UNNotificationActionOptions.destructive)
//
//            let threeMinutesAfter = UNNotificationAction(identifier: "threeMinutesAfter", title: "三分钟后提醒", options: UNNotificationActionOptions.destructive)
//
//            let fourMinutesAfter = UNNotificationAction(identifier: "fourMinutesAfter", title: "四分钟后提醒", options: UNNotificationActionOptions.destructive)
//
//
//
//
//            let category = UNNotificationCategory(identifier: "after", actions: [oneMinutesAfter, twoMinutesAfter, threeMinutesAfter, fourMinutesAfter], intentIdentifiers: [], options: .customDismissAction)
//            let stopCategory = UNNotificationCategory(identifier: "stop", actions: [stop], intentIdentifiers: [], options: .customDismissAction)
//
//
            // Fallback on earlier versions
            let setting = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: [category])
            application.registerUserNotificationSettings(setting)
            
        }
        
        
        
        
        
        return true
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
    
    func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
    }
    
    // 点击 Action 回调
    func application(_ application: UIApplication, handleActionWithIdentifier identifier: String?, for notification: UILocalNotification, completionHandler: @escaping () -> Void) {
        print(identifier)
    }
    
    


}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        print(notification.request.identifier)
        
        completionHandler([.alert, .badge, .sound])
    }
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        
        print(response.notification.request.identifier)
        
        
        let request = UNNotificationRequest(identifier: response.notification.request.identifier, content: response.notification.request.content, trigger: UNTimeIntervalNotificationTrigger(timeInterval: 30, repeats: false))
        UNUserNotificationCenter.current().add(request) { (error) in
           print(error)
        }
        
        
        
        
        

        completionHandler()
        
        
        
        
    }
    
    
    
    
}

