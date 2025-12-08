//
//  ChangeRequest.swift
//  GlisexabDriver
//
//  Created by Arbaz  on 26/11/25.
//

import Foundation

struct Api_ChangeRequest : Codable {
    
    let result : Res_ChangeRequest?
    let message : String?
    let status : String?

    enum CodingKeys: String, CodingKey {

        case result = "result"
        case message = "message"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent(Res_ChangeRequest.self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
}

struct Res_ChangeRequest : Codable {
    
    let id : String?
    let user_id : String?
    let driver_id : String?
    let vehicle_id : String?
    let vehicle_name : String?
    let pickup_lat : String?
    let pickup_lon : String?
    let dropoff_lat : String?
    let dropoff_lon : String?
    let pick_address : String?
    let drop_address : String?
    let description : String?
    let item_weight : String?
    let item_description : String?
    let receiver_name : String?
    let receiver_contact_number : String?
    let total_amount : String?
    let distance : String?
    let date : String?
    let status : String?
    let user_status : String?
    let payment_status : String?
    let payment_type : String?
    let accept_driver_id : String?
    let unique_code : String?
    let unique_code_image : String?
    let timezone : String?
    let date_time : String?
    let reason_title : String?
    let reason_detail : String?
    let payment_time : String?
    let start_time : String?
    let end_time : String?
    let total_time : String?
    let start_waiting_time : String?
    let end_waiting_time : String?
    let total_waiting_time : String?
    let offer_id : String?
    let recipt_total_amount : String?
    let request_type : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case user_id = "user_id"
        case driver_id = "driver_id"
        case vehicle_id = "vehicle_id"
        case vehicle_name = "vehicle_name"
        case pickup_lat = "pickup_lat"
        case pickup_lon = "pickup_lon"
        case dropoff_lat = "dropoff_lat"
        case dropoff_lon = "dropoff_lon"
        case pick_address = "pick_address"
        case drop_address = "drop_address"
        case description = "description"
        case item_weight = "item_weight"
        case item_description = "item_description"
        case receiver_name = "receiver_name"
        case receiver_contact_number = "receiver_contact_number"
        case total_amount = "total_amount"
        case distance = "distance"
        case date = "date"
        case status = "status"
        case user_status = "user_status"
        case payment_status = "payment_status"
        case payment_type = "payment_type"
        case accept_driver_id = "accept_driver_id"
        case unique_code = "unique_code"
        case unique_code_image = "unique_code_image"
        case timezone = "timezone"
        case date_time = "date_time"
        case reason_title = "reason_title"
        case reason_detail = "reason_detail"
        case payment_time = "payment_time"
        case start_time = "start_time"
        case end_time = "end_time"
        case total_time = "total_time"
        case start_waiting_time = "start_waiting_time"
        case end_waiting_time = "end_waiting_time"
        case total_waiting_time = "total_waiting_time"
        case offer_id = "offer_id"
        case recipt_total_amount = "recipt_total_amount"
        case request_type = "request_type"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
        driver_id = try values.decodeIfPresent(String.self, forKey: .driver_id)
        vehicle_id = try values.decodeIfPresent(String.self, forKey: .vehicle_id)
        vehicle_name = try values.decodeIfPresent(String.self, forKey: .vehicle_name)
        pickup_lat = try values.decodeIfPresent(String.self, forKey: .pickup_lat)
        pickup_lon = try values.decodeIfPresent(String.self, forKey: .pickup_lon)
        dropoff_lat = try values.decodeIfPresent(String.self, forKey: .dropoff_lat)
        dropoff_lon = try values.decodeIfPresent(String.self, forKey: .dropoff_lon)
        pick_address = try values.decodeIfPresent(String.self, forKey: .pick_address)
        drop_address = try values.decodeIfPresent(String.self, forKey: .drop_address)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        item_weight = try values.decodeIfPresent(String.self, forKey: .item_weight)
        item_description = try values.decodeIfPresent(String.self, forKey: .item_description)
        receiver_name = try values.decodeIfPresent(String.self, forKey: .receiver_name)
        receiver_contact_number = try values.decodeIfPresent(String.self, forKey: .receiver_contact_number)
        total_amount = try values.decodeIfPresent(String.self, forKey: .total_amount)
        distance = try values.decodeIfPresent(String.self, forKey: .distance)
        date = try values.decodeIfPresent(String.self, forKey: .date)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        user_status = try values.decodeIfPresent(String.self, forKey: .user_status)
        payment_status = try values.decodeIfPresent(String.self, forKey: .payment_status)
        payment_type = try values.decodeIfPresent(String.self, forKey: .payment_type)
        accept_driver_id = try values.decodeIfPresent(String.self, forKey: .accept_driver_id)
        unique_code = try values.decodeIfPresent(String.self, forKey: .unique_code)
        unique_code_image = try values.decodeIfPresent(String.self, forKey: .unique_code_image)
        timezone = try values.decodeIfPresent(String.self, forKey: .timezone)
        date_time = try values.decodeIfPresent(String.self, forKey: .date_time)
        reason_title = try values.decodeIfPresent(String.self, forKey: .reason_title)
        reason_detail = try values.decodeIfPresent(String.self, forKey: .reason_detail)
        payment_time = try values.decodeIfPresent(String.self, forKey: .payment_time)
        start_time = try values.decodeIfPresent(String.self, forKey: .start_time)
        end_time = try values.decodeIfPresent(String.self, forKey: .end_time)
        total_time = try values.decodeIfPresent(String.self, forKey: .total_time)
        start_waiting_time = try values.decodeIfPresent(String.self, forKey: .start_waiting_time)
        end_waiting_time = try values.decodeIfPresent(String.self, forKey: .end_waiting_time)
        total_waiting_time = try values.decodeIfPresent(String.self, forKey: .total_waiting_time)
        offer_id = try values.decodeIfPresent(String.self, forKey: .offer_id)
        recipt_total_amount = try values.decodeIfPresent(String.self, forKey: .recipt_total_amount)
        request_type = try values.decodeIfPresent(String.self, forKey: .request_type)
    }
}
