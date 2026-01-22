//
//  FinalCalculation.swift
//  GlisexabDriver
//
//  Created by Arbaz  on 13/12/25.
//

import Foundation

struct Api_FinalFareCalculation : Codable {
    let user_points : String?
    let convert_point_rate : String?
    let coverted_amount : String?
    let use_reward_amount : String?
    let pay_to_card_amount : String?
    let used_points : String?
    let remain_points : String?
    let long_distance : String?
    let long_time_amount : String?
    let total_fair_amount : String?
    let admin_comi_amount : String?
    let driver_comi_amount : String?
    let driver_sub_amount : String?
    let driver_level : String?
    let ride_amount : String?
    let base_fair : String?
    let safety_fee : String?
    let airport_fee : String?
    let total_waiting_amount : String?
    let total_waiting_driver_amount : String?
    let total_waiting_time : String?
    let stop_total_waiting_time : String?
    let stop_waiting_amount : String?
    let timer_free_minute : String?
    let each_minute_charge : String?
    let stop_Timer_Free_Minute : String?
    let stop_Timer_Per_Min_Charge : String?
    let result : String?
    let message : String?
    let status : String?

    enum CodingKeys: String, CodingKey {

        case user_points = "user_points"
        case convert_point_rate = "convert_point_rate"
        case coverted_amount = "coverted_amount"
        case use_reward_amount = "use_reward_amount"
        case pay_to_card_amount = "pay_to_card_amount"
        case used_points = "used_points"
        case remain_points = "remain_points"
        case long_distance = "long_distance"
        case long_time_amount = "long_time_amount"
        case total_fair_amount = "total_fair_amount"
        case admin_comi_amount = "admin_comi_amount"
        case driver_comi_amount = "driver_comi_amount"
        case driver_sub_amount = "driver_sub_amount"
        case driver_level = "driver_level"
        case ride_amount = "ride_amount"
        case base_fair = "base_fair"
        case safety_fee = "safety_fee"
        case airport_fee = "airport_fee"
        case total_waiting_amount = "total_waiting_amount"
        case total_waiting_driver_amount = "total_waiting_driver_amount"
        case total_waiting_time = "total_waiting_time"
        case stop_total_waiting_time = "stop_total_waiting_time"
        case stop_waiting_amount = "stop_waiting_amount"
        case timer_free_minute = "timer_free_minute"
        case each_minute_charge = "each_minute_charge"
        case stop_Timer_Free_Minute = "Stop_Timer_Free_Minute"
        case stop_Timer_Per_Min_Charge = "Stop_Timer_Per_Min_Charge"
        case result = "result"
        case message = "message"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        user_points = try values.decodeIfPresent(String.self, forKey: .user_points)
        convert_point_rate = try values.decodeIfPresent(String.self, forKey: .convert_point_rate)
        coverted_amount = try values.decodeIfPresent(String.self, forKey: .coverted_amount)
        use_reward_amount = try values.decodeIfPresent(String.self, forKey: .use_reward_amount)
        pay_to_card_amount = try values.decodeIfPresent(String.self, forKey: .pay_to_card_amount)
        used_points = try values.decodeIfPresent(String.self, forKey: .used_points)
        remain_points = try values.decodeIfPresent(String.self, forKey: .remain_points)
        long_distance = try values.decodeIfPresent(String.self, forKey: .long_distance)
        long_time_amount = try values.decodeIfPresent(String.self, forKey: .long_time_amount)
        total_fair_amount = try values.decodeIfPresent(String.self, forKey: .total_fair_amount)
        admin_comi_amount = try values.decodeIfPresent(String.self, forKey: .admin_comi_amount)
        driver_comi_amount = try values.decodeIfPresent(String.self, forKey: .driver_comi_amount)
        driver_sub_amount = try values.decodeIfPresent(String.self, forKey: .driver_sub_amount)
        driver_level = try values.decodeIfPresent(String.self, forKey: .driver_level)
        ride_amount = try values.decodeIfPresent(String.self, forKey: .ride_amount)
        base_fair = try values.decodeIfPresent(String.self, forKey: .base_fair)
        safety_fee = try values.decodeIfPresent(String.self, forKey: .safety_fee)
        airport_fee = try values.decodeIfPresent(String.self, forKey: .airport_fee)
        total_waiting_amount = try values.decodeIfPresent(String.self, forKey: .total_waiting_amount)
        total_waiting_driver_amount = try values.decodeIfPresent(String.self, forKey: .total_waiting_driver_amount)
        total_waiting_time = try values.decodeIfPresent(String.self, forKey: .total_waiting_time)
        stop_total_waiting_time = try values.decodeIfPresent(String.self, forKey: .stop_total_waiting_time)
        stop_waiting_amount = try values.decodeIfPresent(String.self, forKey: .stop_waiting_amount)
        timer_free_minute = try values.decodeIfPresent(String.self, forKey: .timer_free_minute)
        each_minute_charge = try values.decodeIfPresent(String.self, forKey: .each_minute_charge)
        stop_Timer_Free_Minute = try values.decodeIfPresent(String.self, forKey: .stop_Timer_Free_Minute)
        stop_Timer_Per_Min_Charge = try values.decodeIfPresent(String.self, forKey: .stop_Timer_Per_Min_Charge)
        result = try values.decodeIfPresent(String.self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
}
