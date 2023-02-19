//
//  ContentView.swift
//  Save_It_Right
//
//  Created by Shouq Turki Bin Tuwaym on 05/02/2023.
//

import SwiftUI

func fixWidthSize(
    imgSize:CGSize,
    viewSize:CGSize,
    safeArea: EdgeInsets,
    height: Double,
    devider: Double,
    margins: Double
) -> CGFloat {
    
    let imgAsp = imgSize.width / imgSize.height
    let viewAsp = ( ( viewSize.width - margins - safeArea.leading - safeArea.trailing ) /  devider ) / height
    if ( imgAsp > viewAsp
    ){
        return imgSize.width * imgAsp / viewAsp
    }else{
        return imgSize.width
    }
    
}

func fixHeightSize(
    imgSize:CGSize,
    viewSize:CGSize,
    safeArea: EdgeInsets,
    height: Double,
    devider: Double,
    margins: Double
) -> CGFloat {
    
    let imgAsp = imgSize.height / imgSize.width
    let viewAsp = height / ( ( viewSize.width - margins - safeArea.leading - safeArea.trailing ) /  devider )
    if ( imgAsp > viewAsp
    ){
        return height * imgAsp / viewAsp
    }else{
        return height
    }
    
}


extension LocalizedStringKey {
    var stringKey: String? {
        Mirror(reflecting: self).children.first(where: { $0.label == "key" })?.value as? String
    }
    
    func stringValue(locale: Locale = .current) -> String? {
        guard let stringKey = self.stringKey else { return nil }
        let language = locale.languageCode
        guard let path = Bundle.main.path(forResource: language, ofType: "lproj") else { return stringKey }
        guard let bundle = Bundle(path: path) else { return stringKey }
        let localizedString = NSLocalizedString(stringKey, bundle: bundle, comment: "")
        return localizedString
    }
}

func getDate(_ time:Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd / MM / yyyy"
    return formatter.string(from: time)
}


class NotificationManager {
    
    static let instance = NotificationManager()
    
    func requestAuthorization () {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { (success, error) in
            if let error = error {
                print("Error\(error)")
                
            } else {
                print("SUCCESS")
            }
        }
    }
    
    func scheduleNotifications(_ date: Date, _ title: String, _ subtitle: String) {
        
        //        let systemSoundID: SystemSoundID = 1016
        //        AudioServicesPlaySystemSound ( systemSoundID)
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = subtitle
        content.sound = UNNotificationSound.default
        content.badge = 1
        
        // calender
//        let nextTriggerDate = Calendar.current.date(byAdding: .second, value: 60, to: Date())!
        let nextTriggerDate = Calendar.current.date(byAdding: .minute, value: 2, to: date)!
        let comps = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: nextTriggerDate)
        let trigger = UNCalendarNotificationTrigger(dateMatching: comps, repeats: true)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString,
                                            content: content,
                                            trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
}
