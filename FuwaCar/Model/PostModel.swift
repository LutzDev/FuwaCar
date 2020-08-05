//
//  PostModel.swift
//  FuwaCar
//
//  Created by Lutz Weigold on 16.07.20.
//  Copyright © 2020 Lutz Weigold. All rights reserved.
//

import Foundation

class PostModel{
    var rideDescription: String?
    var carImageUrl: String?
    var rideDestination: String?
    var rideStartingPoint: String?
    
    var departureTime: [String: Any]?
    
    var rideHour: String?
    var rideMinutes: String?
    var rideMonth: String?
    var rideWeekday: String?
    var uid: String?
    var phoneNumber: String?
    
    init(dictionary: [String: Any]) {
        
        departureTime = dictionary["departureTime"] as? Dictionary
                   
        if let _hour = departureTime?["hour"] as? String{
            rideHour = _hour
        }
        
        if let _minute = departureTime?["minute"] as? String{
            rideMinutes = _minute
        }
        
        if let _month = departureTime?["month"] as? String{
            rideMonth = _month
        }
        
        if let _weekday = departureTime?["weekday"] as? String{
            rideWeekday = _weekday
        }
        
        phoneNumber = dictionary["phoneNumber"] as? String
        uid = dictionary["uid"] as? String
        carImageUrl = dictionary["imageUrl"] as? String
        rideDescription = dictionary["carDescription"] as? String
        rideDestination = dictionary["destination"] as? String
        rideStartingPoint = dictionary["startingPoint"] as? String
    }
}
