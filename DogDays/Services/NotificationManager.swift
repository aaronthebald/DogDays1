//
//  NotificationManager.swift
//  DogDays
//
//  Created by Aaron Wilson on 3/28/23.
//

import Foundation
import UserNotifications

class NotificationManager {
    static let instance = NotificationManager() //Singleton
    
    func requestAuthorization() {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { success, error in
            if let error = error {
                print("ERROR: \(error)")
            } else {
                print("SUCCESS")
            }
        }
    }

    func scheduleNotification(forDate: Date) {
        // Step 1: Create a UNUserNotificationCenter instance
        let center = UNUserNotificationCenter.current()
        
        // Step 2: Define the notification content
        let content = UNMutableNotificationContent()
        content.title = "You have an upcoming Event!"
        
        
        // Step 3: Define the trigger based on the specified date
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: forDate)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        // Step 4: Create a request with the specified content and trigger
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        // Step 5: Add the request to the notification center
        center.add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            }
        }
    }

//    func scheduleNotificaton() {
//        let content = UNMutableNotificationContent()
//        content.title = "You have an upcoming Event!"
//        content.sound = .default
//        content.badge = 1
//
//        var date = DateC
//
//        let trigger = UNCalendarNotificationTrigger(dateMatching: , repeats: <#T##Bool#>)
//    }
    
    
}
