//
//  VehicleList.swift
//  GlisexabDriver
//
//  Created by Pushpendra Mandloi on 18/11/25.
//

import Foundation

struct Api_Vehiclelist: Codable {
    let result: [Res_VehicleList]?
    let message: String?
    let status: String?
}

struct Res_VehicleList: Codable, Identifiable {
    
    // MARK: - Required for SwiftUI
    var id: String { rawId ?? UUID().uuidString }
    
    // MARK: - Actual server keys
    let rawId: String?
    let vehicle: String?
    let image: String?
    let status: String?
    let no_of_bag: String?
    let date_time: String?
    let base_fair: String?
    let per_hour: String?
    let per_minute: String?
    let per_minute_waiting_charge: String?
    let rush_hour_start_time: String?
    let rush_hour_end_time: String?
    let rush_hour_price: String?
    let per_km_price: String?
    let type: String?
    let no_of_passenger: String?
    let list_order: String?
    let timer_free_minute: String?
    let each_minute_charge: String?
    let stop_Timer_Free_Minute: String?
    let stop_Timer_Per_Min_Charge: String?
    let hourly_rate: String?
    let driver_earning_percentage: String?
    let no_show_fee: String?
    let cancelation_fee: String?
    let booking_fee: String?
    let web_Stop_Price: String?
    let safety_fee: String?
    let airport_fee: String?
    let long_time_pickup_per_mile_fee: String?
    let long_time_pickup_mile_free: String?
    let request_time_min: String?
    let commision: String?
    let vehicle_added: String?
    
    enum CodingKeys: String, CodingKey {
        case rawId = "id"
        case vehicle
        case image
        case status
        case no_of_bag
        case date_time
        case base_fair
        case per_hour
        case per_minute
        case per_minute_waiting_charge
        case rush_hour_start_time
        case rush_hour_end_time
        case rush_hour_price
        case per_km_price
        case type
        case no_of_passenger
        case list_order
        case timer_free_minute
        case each_minute_charge
        case stop_Timer_Free_Minute = "Stop_Timer_Free_Minute"
        case stop_Timer_Per_Min_Charge = "Stop_Timer_Per_Min_Charge"
        case hourly_rate
        case driver_earning_percentage
        case no_show_fee
        case cancelation_fee
        case booking_fee
        case web_Stop_Price = "Web_Stop_Price"
        case safety_fee
        case airport_fee
        case long_time_pickup_per_mile_fee
        case long_time_pickup_mile_free
        case request_time_min
        case commision
        case vehicle_added
    }
}
