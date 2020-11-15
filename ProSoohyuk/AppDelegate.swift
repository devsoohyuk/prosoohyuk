//
//  AppDelegate.swift
//  ProSoohyuk
//
//  Created by soohyuk hong on 2020/11/15.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        FirebaseApp.configure()
        // PUSH 서비스 설정
        setupPushService(application)
        
        application.applicationIconBadgeNumber = 0
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}

extension AppDelegate : UNUserNotificationCenterDelegate {
    
    // 디바이스 토큰
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let deviceTokenString = deviceToken.map { String(format: "%02x", $0) }.joined()
        print("Apple registration token: \(deviceToken) \(deviceTokenString)")
        //        if let loadToken = UserDefaultsManager.shared.loadAPNSToken() {
        //            if loadToken != deviceTokenString {
        //                updateToken(token: deviceTokenString)
        //            }
        //        } else {
        //            updateToken(token: deviceTokenString)
        //        }
    }
    
    
    func updateToken(token: String) {
        //        UserDefaultsManager.shared.saveAPNSToken(value: token)
        //
        //        let req = PushRestoreRequest(token: token)
        //        API.shared.request(url: req.getAPI(), param: req.getParam()) { (response:Swift.Result<PushRestoreResponse, TPError>) -> Void in
        //            switch response {
        //            case .success(let data):
        //                print(data)
        //            case .failure(let error):
        //                print(error)
        //            }
        //
        //        }
    }
    
    private func setupPushService(_ application: UIApplication) {
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        push(application: UIApplication.shared, userInfo: userInfo)
        completionHandler([.alert, .badge, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let notification = response.notification
        let userInfo = notification.request.content.userInfo
        if response.actionIdentifier == UNNotificationDismissActionIdentifier {
            print ("Message Closed")
        }
        else if response.actionIdentifier == UNNotificationDefaultActionIdentifier {
            
            // 여기서 위의 받았을 때 mainVC나 이동로직 이상하게 쓰면 UNUserNotificationCenterDelegate methods not being called 나옴
        }
        
        push(application: UIApplication.shared, userInfo: userInfo)
        completionHandler()
    }
    
    private func push(application: UIApplication, userInfo: [AnyHashable : Any]) {
        application.applicationIconBadgeNumber = 0
    }
}


