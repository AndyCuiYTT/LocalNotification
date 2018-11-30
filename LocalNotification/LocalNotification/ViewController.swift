//
//  ViewController.swift
//  LocalNotification
//
//  Created by qiuweniOS on 2018/11/28.
//  Copyright © 2018 AndyCuiYTT. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        if #available(iOS 10.0, *) {
            let content = UNMutableNotificationContent()
            content.title = "iOS 10 本地通知"
            content.subtitle = "初步尝试"
            content.body = "新通知变化很大，之前本地通知和远程推送是两个类，现在合成一个了。这是一条测试通知"
            content.badge = 1
            content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "apple.caf"))
            content.categoryIdentifier = "after"
            
            
            // 触发时间
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 20, repeats: false)
            
            let request = UNNotificationRequest(identifier: "iOS10", content: content, trigger: trigger)
            
            let center = UNUserNotificationCenter.current()
            
            let oneMinutesAfter = UNNotificationAction(identifier: "oneMinutesAfter", title: "一分钟后提醒", options: UNNotificationActionOptions.destructive)
            
            let twoMinutesAfter = UNNotificationAction(identifier: "twoMinutesAfter", title: "二分钟后提醒", options: UNNotificationActionOptions.destructive)
            
            let threeMinutesAfter = UNNotificationAction(identifier: "threeMinutesAfter", title: "三分钟后提醒", options: UNNotificationActionOptions.destructive)
            
            let fourMinutesAfter = UNNotificationAction(identifier: "fourMinutesAfter", title: "四分钟后提醒", options: UNNotificationActionOptions.destructive)
            
             let stop = UNNotificationAction(identifier: "stop", title: "停止", options: UNNotificationActionOptions.foreground)
            
            
            
            let category = UNNotificationCategory(identifier: "after", actions: [oneMinutesAfter, twoMinutesAfter, threeMinutesAfter, fourMinutesAfter], intentIdentifiers: [], options: .customDismissAction)
            let stopCategory = UNNotificationCategory(identifier: "stop", actions: [stop], intentIdentifiers: [], options: .customDismissAction)
            
            center.setNotificationCategories([category, stopCategory])
            
            
            
            center.add(request) { (error) in
                if error == nil {
                    print("成功")
                } else {
                    print("失败")
                }
            }
        } else {
            
            
            UIApplication.shared.cancelAllLocalNotifications()
//            UIApplication.shared.cancelLocalNotification(<#T##notification: UILocalNotification##UILocalNotification#>)
            
            let noti = UILocalNotification()
            
            noti.fireDate = Date(timeIntervalSinceNow: 20)
            if #available(iOS 8.2, *) {
                noti.alertTitle = "测试本地推送"
            } else {
                // Fallback on earlier versions
            }
            noti.alertBody = "触发时间（fireDate，timeZone，repeatInterval(重复方式)，repeatCalendar）//如果发送通知方式为即时发送则配置无意义"
            noti.repeatInterval = NSCalendar.Unit.minute
            noti.soundName = "apple.caf1"// Bundle.main.path(forResource: "apple", ofType: "caf")//
            
            noti.alertAction = "Action"
            
            noti.category = "after"
        
            
            UIApplication.shared.scheduleLocalNotification(noti)
            
            
            print("的点点滴滴")
        }
        
        
        
        
        
        
        
    }
    
    @available(iOS 10.0, *)
    func registerLocalNotification() {
        
        let center = UNUserNotificationCenter.current()
//        center.delegate = self
        center.requestAuthorization(options: [.alert, .badge, .sound]) { (flag, error) in
            if flag {
                print("success")
            } else {
                print("faile")
            }
        }
    }
    
    
    
    @available(iOS 10.0, *)
    func getNotificationContent(title: String, subtitle: String, body: String, bage: NSNumber? = nil, sound: UNNotificationSound? = nil, categoryIdentifier identifier: String? = nil, userInfo: [AnyHashable : Any]? = nil, attachments: [UNNotificationAttachment]? = nil) -> UNMutableNotificationContent {
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = title
        content.body = body
        if let b = bage {
            content.badge = b
        }
        
        if let s = sound {
            content.sound = s
        }
        
        if let u = userInfo {
            content.userInfo = u
        }
        
        if let a = attachments {
            content.attachments = a
        }
        
        if let i = identifier {
            content.categoryIdentifier = i
        }
        
        
      
        return content
    }

    @available(iOS 10.0, *)
    func getNotificationRequest(identifier: String, content: UNNotificationContent, trigger: UNNotificationTrigger) -> UNNotificationRequest {
        return UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
    }
    
    @available(iOS 10.0, *)
    func getNotificationRequest(identifier: String, content: UNNotificationContent, timeInterval: TimeInterval, repeats: Bool) -> UNNotificationRequest {
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: repeats)
        return UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
    }
    
    @available(iOS 10.0, *)
    func getNotificationRequest(identifier: String, content: UNNotificationContent, dateMatching dateComponents: DateComponents, repeats: Bool) -> UNNotificationRequest {
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: repeats)
        return UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
    }
    
    @available(iOS 8.0, *)
    func getLocalNotification(title: String, body: String, fireDate: Date) -> UILocalNotification {
        let noti = UILocalNotification()
        noti.fireDate = fireDate
        if #available(iOS 8.2, *) {
            noti.alertTitle = title
        }
        noti.alertBody = body
        return noti
    }
    
    
    @available(iOS 8.0, *)
    func getLocalNotification(title: String, body: String, fireData: Date, repeatInterval: NSCalendar.Unit? = nil, soundName: String? = nil, applicationIconBadgeNumber number: Int = 0, userInfo: [AnyHashable: Any]? = nil,  alertAction: String? = nil, identifier: String? = nil, categoryIdentifier: String? = nil) {
        let noti = UILocalNotification()
        noti.applicationIconBadgeNumber = number
        noti.fireDate = fireData
        if #available(iOS 8.2, *) {
            noti.alertTitle = title
        }
        
        noti.alertBody = body
        if let r = repeatInterval {
            noti.repeatInterval = r
        }
        
        if let s = soundName {
            noti.soundName = s
        }
        
        if let a = alertAction {
            noti.alertAction = a
        }
       
        if let c = categoryIdentifier {
            noti.category = c
        }
        
        if var u = userInfo, let i = identifier {
            u["identifier"] = i
            noti.userInfo = u
        } else if let u = userInfo {
            noti.userInfo = u
        } else if let i = identifier {
            noti.userInfo = ["identifier": i]
        }

    }
    
    
    func cancelAllLocalNotifications() {
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().removeAllDeliveredNotifications() // 展示过的通知
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests() // 未展示过的通知
        } else if #available(iOS 8.0, *) {
            UIApplication.shared.cancelAllLocalNotifications()
        }
    }
    
    
    /// 根据标识移除本地通知
    ///
    /// iOS 10 之前没有唯一标识,添加本地通知时将标识放到 userInfo 中
    ///
    /// - Parameter identifier: 唯一标识
    func cancelAllLocalNotification(identifier: String) {
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: [identifier]) // 展示过的通知
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [identifier]) // 未展示过的通知
        } else if #available(iOS 8.0, *) {
            
            for localNotification in UIApplication.shared.scheduledLocalNotifications ?? [] {
                if let key = localNotification.userInfo?["identifier"] as? String, key == identifier {
                    UIApplication.shared.cancelLocalNotification(localNotification)
                    return
                }
            }
        }
    }
    
}




