//
//  AppDelegate.swift
//  EBApp
//
//  Created by Md. Afzal Hossain on 8/26/21.
//

import UIKit
import GoogleMaps

let googleApiKey="AIzaSyD6R68IylSixf_h5XT1maMGj-SYxlnsfvs"

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        GMSServices.provideAPIKey(googleApiKey)
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



//class AnyGestureRecognizer: UIGestureRecognizer {
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
//        if let touchedView = touches.first?.view, touchedView is UIControl {
//            state = .cancelled
//
//        } else if let touchedView = touches.first?.view as? UITextView, touchedView.isEditable {
//            state = .cancelled
//
//        } else {
//            state = .began
//        }
//    }
//
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//       state = .ended
//    }
//
//    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {
//        state = .cancelled
//    }
//}
