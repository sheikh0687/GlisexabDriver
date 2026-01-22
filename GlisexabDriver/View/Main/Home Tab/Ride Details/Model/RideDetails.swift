//
//  RideDetails.swift
//  GlisexabDriver
//
//  Created by Arbaz  on 13/12/25.
//

import Foundation

struct Api_RideDetails : Codable {
    let result : Res_RideDetail?
    let message : String?
    let status : String?

    enum CodingKeys: String, CodingKey {

        case result = "result"
        case message = "message"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent(Res_RideDetail.self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
}

struct Res_RideDetail : Codable {
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
    let admin_commission : String?
    let driver_amount : String?
    let driver_sub_amount : String?
    let tip_amount : String?
    let distance : String?
    let date : String?
    let time : String?
    let status : String?
    let user_status : String?
    let payment_status : String?
    let payment_type : String?
    let accept_driver_id : String?
    let accept_driver_lat : String?
    let accept_driver_lon : String?
    let accept_driver_distance : String?
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
    let total_waiting_amount : String?
    let total_waiting_driver_amount : String?
    let offer_id : String?
    let recipt_total_amount : String?
    let request_type : String?
    let guest_name : String?
    let guest_email : String?
    let guest_mobile : String?
    let book_for_others : String?
    let booking_type : String?
    let safety_fee : String?
    let airport_fee : String?
    let stop_total_waiting_time : String?
    let stop_waiting_amount : String?
    let driver_level : String?
    let request_add_time : String?
    let main_timer_disabled : String?
    let booster_seat : String?
    let rearface_seat : String?
    let forwardface_seat : String?
    let airline_name : String?
    let flight_number : String?
    let airline_booking : String?
    let card_id : String?
    let cust_id : String?
    let tip_thankyou_msg : String?
    let user_details : User_details?
    let driver_details : Driver_details?
    let car_details : Car_details?
    let rating_review_status : String?
    let driver_amount_plus_tip : String?
    let total_amount_with_tip_user_side : String?
    let user_sub_amount_user_side : String?

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
        case admin_commission = "admin_commission"
        case driver_amount = "driver_amount"
        case driver_sub_amount = "driver_sub_amount"
        case tip_amount = "tip_amount"
        case distance = "distance"
        case date = "date"
        case time = "time"
        case status = "status"
        case user_status = "user_status"
        case payment_status = "payment_status"
        case payment_type = "payment_type"
        case accept_driver_id = "accept_driver_id"
        case accept_driver_lat = "accept_driver_lat"
        case accept_driver_lon = "accept_driver_lon"
        case accept_driver_distance = "accept_driver_distance"
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
        case total_waiting_amount = "total_waiting_amount"
        case total_waiting_driver_amount = "total_waiting_driver_amount"
        case offer_id = "offer_id"
        case recipt_total_amount = "recipt_total_amount"
        case request_type = "request_type"
        case guest_name = "guest_name"
        case guest_email = "guest_email"
        case guest_mobile = "guest_mobile"
        case book_for_others = "book_for_others"
        case booking_type = "booking_type"
        case safety_fee = "safety_fee"
        case airport_fee = "airport_fee"
        case stop_total_waiting_time = "stop_total_waiting_time"
        case stop_waiting_amount = "stop_waiting_amount"
        case driver_level = "driver_level"
        case request_add_time = "request_add_time"
        case main_timer_disabled = "main_timer_disabled"
        case booster_seat = "booster_seat"
        case rearface_seat = "rearface_seat"
        case forwardface_seat = "forwardface_seat"
        case airline_name = "airline_name"
        case flight_number = "flight_number"
        case airline_booking = "airline_booking"
        case card_id = "card_id"
        case cust_id = "cust_id"
        case tip_thankyou_msg = "tip_thankyou_msg"
        case user_details = "user_details"
        case driver_details = "driver_details"
        case car_details = "car_details"
        case rating_review_status = "rating_review_status"
        case driver_amount_plus_tip = "driver_amount_plus_tip"
        case total_amount_with_tip_user_side = "total_amount_with_tip_user_side"
        case user_sub_amount_user_side = "user_sub_amount_user_side"
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
        admin_commission = try values.decodeIfPresent(String.self, forKey: .admin_commission)
        driver_amount = try values.decodeIfPresent(String.self, forKey: .driver_amount)
        driver_sub_amount = try values.decodeIfPresent(String.self, forKey: .driver_sub_amount)
        tip_amount = try values.decodeIfPresent(String.self, forKey: .tip_amount)
        distance = try values.decodeIfPresent(String.self, forKey: .distance)
        date = try values.decodeIfPresent(String.self, forKey: .date)
        time = try values.decodeIfPresent(String.self, forKey: .time)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        user_status = try values.decodeIfPresent(String.self, forKey: .user_status)
        payment_status = try values.decodeIfPresent(String.self, forKey: .payment_status)
        payment_type = try values.decodeIfPresent(String.self, forKey: .payment_type)
        accept_driver_id = try values.decodeIfPresent(String.self, forKey: .accept_driver_id)
        accept_driver_lat = try values.decodeIfPresent(String.self, forKey: .accept_driver_lat)
        accept_driver_lon = try values.decodeIfPresent(String.self, forKey: .accept_driver_lon)
        accept_driver_distance = try values.decodeIfPresent(String.self, forKey: .accept_driver_distance)
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
        total_waiting_amount = try values.decodeIfPresent(String.self, forKey: .total_waiting_amount)
        total_waiting_driver_amount = try values.decodeIfPresent(String.self, forKey: .total_waiting_driver_amount)
        offer_id = try values.decodeIfPresent(String.self, forKey: .offer_id)
        recipt_total_amount = try values.decodeIfPresent(String.self, forKey: .recipt_total_amount)
        request_type = try values.decodeIfPresent(String.self, forKey: .request_type)
        guest_name = try values.decodeIfPresent(String.self, forKey: .guest_name)
        guest_email = try values.decodeIfPresent(String.self, forKey: .guest_email)
        guest_mobile = try values.decodeIfPresent(String.self, forKey: .guest_mobile)
        book_for_others = try values.decodeIfPresent(String.self, forKey: .book_for_others)
        booking_type = try values.decodeIfPresent(String.self, forKey: .booking_type)
        safety_fee = try values.decodeIfPresent(String.self, forKey: .safety_fee)
        airport_fee = try values.decodeIfPresent(String.self, forKey: .airport_fee)
        stop_total_waiting_time = try values.decodeIfPresent(String.self, forKey: .stop_total_waiting_time)
        stop_waiting_amount = try values.decodeIfPresent(String.self, forKey: .stop_waiting_amount)
        driver_level = try values.decodeIfPresent(String.self, forKey: .driver_level)
        request_add_time = try values.decodeIfPresent(String.self, forKey: .request_add_time)
        main_timer_disabled = try values.decodeIfPresent(String.self, forKey: .main_timer_disabled)
        booster_seat = try values.decodeIfPresent(String.self, forKey: .booster_seat)
        rearface_seat = try values.decodeIfPresent(String.self, forKey: .rearface_seat)
        forwardface_seat = try values.decodeIfPresent(String.self, forKey: .forwardface_seat)
        airline_name = try values.decodeIfPresent(String.self, forKey: .airline_name)
        flight_number = try values.decodeIfPresent(String.self, forKey: .flight_number)
        airline_booking = try values.decodeIfPresent(String.self, forKey: .airline_booking)
        card_id = try values.decodeIfPresent(String.self, forKey: .card_id)
        cust_id = try values.decodeIfPresent(String.self, forKey: .cust_id)
        tip_thankyou_msg = try values.decodeIfPresent(String.self, forKey: .tip_thankyou_msg)
        user_details = try values.decodeIfPresent(User_details.self, forKey: .user_details)
        driver_details = try values.decodeIfPresent(Driver_details.self, forKey: .driver_details)
        car_details = try values.decodeIfPresent(Car_details.self, forKey: .car_details)
        rating_review_status = try values.decodeIfPresent(String.self, forKey: .rating_review_status)
        driver_amount_plus_tip = try values.decodeIfPresent(String.self, forKey: .driver_amount_plus_tip)
        total_amount_with_tip_user_side = try values.decodeIfPresent(String.self, forKey: .total_amount_with_tip_user_side)
        user_sub_amount_user_side = try values.decodeIfPresent(String.self, forKey: .user_sub_amount_user_side)
    }
}

struct Driver_details : Codable {
    let id : String?
    let cust_id : String?
    let vehicle_id : String?
    let vehicle_name : String?
    let first_name : String?
    let last_name : String?
    let username : String?
    let mobile : String?
    let mobile_witth_country_code : String?
    let email : String?
    let password : String?
    let company_name : String?
    let company_logo : String?
    let country_id : String?
    let country : String?
    let state_id : String?
    let city_id : String?
    let image : String?
    let type : String?
    let social_id : String?
    let lat : String?
    let lon : String?
    let address : String?
    let gender : String?
    let wallet : String?
    let registration_no : String?
    let licence_number : String?
    let licence_image : String?
    let vehicle_image : String?
    let admin_vehicle_image : String?
    let vehicle_insura_image : String?
    let vehicle_work_type : String?
    let registration_image : String?
    let air_port_sticker_front : String?
    let air_port_sticker_back : String?
    let badge_image : String?
    let register_id : String?
    let ios_register_id : String?
    let status : String?
    let available_status : String?
    let code : String?
    let date_time : String?
    let plan_id : String?
    let exp_date : String?
    let total_deliveries : String?
    let expiry_month : String?
    let expiry_year : String?
    let card_number : String?
    let card_holder_name : String?
    let account_holder_name : String?
    let bank_name : String?
    let bank_branch : String?
    let account_number : String?
    let bank_address : String?
    let swify_bic_code : String?
    let venmo_account : String?
    let zelle_transfer : String?
    let commission : String?
    let unique_code : String?
    let unique_code_image : String?
    let referral_code : String?
    let signup_referral_code : String?
    let points : String?
    let fav_driver : String?
    let rating : String?
    let rating_count : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case cust_id = "cust_id"
        case vehicle_id = "vehicle_id"
        case vehicle_name = "vehicle_name"
        case first_name = "first_name"
        case last_name = "last_name"
        case username = "username"
        case mobile = "mobile"
        case mobile_witth_country_code = "mobile_witth_country_code"
        case email = "email"
        case password = "password"
        case company_name = "company_name"
        case company_logo = "company_logo"
        case country_id = "country_id"
        case country = "country"
        case state_id = "state_id"
        case city_id = "city_id"
        case image = "image"
        case type = "type"
        case social_id = "social_id"
        case lat = "lat"
        case lon = "lon"
        case address = "address"
        case gender = "gender"
        case wallet = "wallet"
        case registration_no = "registration_no"
        case licence_number = "licence_number"
        case licence_image = "licence_image"
        case vehicle_image = "vehicle_image"
        case admin_vehicle_image = "admin_vehicle_image"
        case vehicle_insura_image = "vehicle_insura_image"
        case vehicle_work_type = "vehicle_work_type"
        case registration_image = "registration_image"
        case air_port_sticker_front = "air_port_sticker_front"
        case air_port_sticker_back = "air_port_sticker_back"
        case badge_image = "badge_image"
        case register_id = "register_id"
        case ios_register_id = "ios_register_id"
        case status = "status"
        case available_status = "available_status"
        case code = "code"
        case date_time = "date_time"
        case plan_id = "plan_id"
        case exp_date = "exp_date"
        case total_deliveries = "total_deliveries"
        case expiry_month = "expiry_month"
        case expiry_year = "expiry_year"
        case card_number = "card_number"
        case card_holder_name = "card_holder_name"
        case account_holder_name = "account_holder_name"
        case bank_name = "bank_name"
        case bank_branch = "bank_branch"
        case account_number = "account_number"
        case bank_address = "bank_address"
        case swify_bic_code = "swify_bic_code"
        case venmo_account = "venmo_account"
        case zelle_transfer = "zelle_transfer"
        case commission = "commission"
        case unique_code = "unique_code"
        case unique_code_image = "unique_code_image"
        case referral_code = "referral_code"
        case signup_referral_code = "signup_referral_code"
        case points = "points"
        case fav_driver = "fav_driver"
        case rating = "rating"
        case rating_count = "rating_count"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        cust_id = try values.decodeIfPresent(String.self, forKey: .cust_id)
        vehicle_id = try values.decodeIfPresent(String.self, forKey: .vehicle_id)
        vehicle_name = try values.decodeIfPresent(String.self, forKey: .vehicle_name)
        first_name = try values.decodeIfPresent(String.self, forKey: .first_name)
        last_name = try values.decodeIfPresent(String.self, forKey: .last_name)
        username = try values.decodeIfPresent(String.self, forKey: .username)
        mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
        mobile_witth_country_code = try values.decodeIfPresent(String.self, forKey: .mobile_witth_country_code)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        password = try values.decodeIfPresent(String.self, forKey: .password)
        company_name = try values.decodeIfPresent(String.self, forKey: .company_name)
        company_logo = try values.decodeIfPresent(String.self, forKey: .company_logo)
        country_id = try values.decodeIfPresent(String.self, forKey: .country_id)
        country = try values.decodeIfPresent(String.self, forKey: .country)
        state_id = try values.decodeIfPresent(String.self, forKey: .state_id)
        city_id = try values.decodeIfPresent(String.self, forKey: .city_id)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        social_id = try values.decodeIfPresent(String.self, forKey: .social_id)
        lat = try values.decodeIfPresent(String.self, forKey: .lat)
        lon = try values.decodeIfPresent(String.self, forKey: .lon)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        gender = try values.decodeIfPresent(String.self, forKey: .gender)
        wallet = try values.decodeIfPresent(String.self, forKey: .wallet)
        registration_no = try values.decodeIfPresent(String.self, forKey: .registration_no)
        licence_number = try values.decodeIfPresent(String.self, forKey: .licence_number)
        licence_image = try values.decodeIfPresent(String.self, forKey: .licence_image)
        vehicle_image = try values.decodeIfPresent(String.self, forKey: .vehicle_image)
        admin_vehicle_image = try values.decodeIfPresent(String.self, forKey: .admin_vehicle_image)
        vehicle_insura_image = try values.decodeIfPresent(String.self, forKey: .vehicle_insura_image)
        vehicle_work_type = try values.decodeIfPresent(String.self, forKey: .vehicle_work_type)
        registration_image = try values.decodeIfPresent(String.self, forKey: .registration_image)
        air_port_sticker_front = try values.decodeIfPresent(String.self, forKey: .air_port_sticker_front)
        air_port_sticker_back = try values.decodeIfPresent(String.self, forKey: .air_port_sticker_back)
        badge_image = try values.decodeIfPresent(String.self, forKey: .badge_image)
        register_id = try values.decodeIfPresent(String.self, forKey: .register_id)
        ios_register_id = try values.decodeIfPresent(String.self, forKey: .ios_register_id)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        available_status = try values.decodeIfPresent(String.self, forKey: .available_status)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        date_time = try values.decodeIfPresent(String.self, forKey: .date_time)
        plan_id = try values.decodeIfPresent(String.self, forKey: .plan_id)
        exp_date = try values.decodeIfPresent(String.self, forKey: .exp_date)
        total_deliveries = try values.decodeIfPresent(String.self, forKey: .total_deliveries)
        expiry_month = try values.decodeIfPresent(String.self, forKey: .expiry_month)
        expiry_year = try values.decodeIfPresent(String.self, forKey: .expiry_year)
        card_number = try values.decodeIfPresent(String.self, forKey: .card_number)
        card_holder_name = try values.decodeIfPresent(String.self, forKey: .card_holder_name)
        account_holder_name = try values.decodeIfPresent(String.self, forKey: .account_holder_name)
        bank_name = try values.decodeIfPresent(String.self, forKey: .bank_name)
        bank_branch = try values.decodeIfPresent(String.self, forKey: .bank_branch)
        account_number = try values.decodeIfPresent(String.self, forKey: .account_number)
        bank_address = try values.decodeIfPresent(String.self, forKey: .bank_address)
        swify_bic_code = try values.decodeIfPresent(String.self, forKey: .swify_bic_code)
        venmo_account = try values.decodeIfPresent(String.self, forKey: .venmo_account)
        zelle_transfer = try values.decodeIfPresent(String.self, forKey: .zelle_transfer)
        commission = try values.decodeIfPresent(String.self, forKey: .commission)
        unique_code = try values.decodeIfPresent(String.self, forKey: .unique_code)
        unique_code_image = try values.decodeIfPresent(String.self, forKey: .unique_code_image)
        referral_code = try values.decodeIfPresent(String.self, forKey: .referral_code)
        signup_referral_code = try values.decodeIfPresent(String.self, forKey: .signup_referral_code)
        points = try values.decodeIfPresent(String.self, forKey: .points)
        fav_driver = try values.decodeIfPresent(String.self, forKey: .fav_driver)
        rating = try values.decodeIfPresent(String.self, forKey: .rating)
        rating_count = try values.decodeIfPresent(String.self, forKey: .rating_count)
    }

}

struct Car_details : Codable {
    let id : String?
    let vehicle : String?
    let image : String?
    let status : String?
    let no_of_bag : String?
    let date_time : String?
    let base_fair : String?
    let per_hour : String?
    let per_minute : String?
    let per_minute_waiting_charge : String?
    let rush_hour_start_time : String?
    let rush_hour_end_time : String?
    let rush_hour_price : String?
    let per_km_price : String?
    let type : String?
    let no_of_passenger : String?
    let list_order : String?
    let timer_free_minute : String?
    let each_minute_charge : String?
    let stop_Timer_Free_Minute : String?
    let stop_Timer_Per_Min_Charge : String?
    let hourly_rate : String?
    let driver_earning_percentage : String?
    let no_show_fee : String?
    let cancelation_fee : String?
    let booking_fee : String?
    let web_Stop_Price : String?
    let safety_fee : String?
    let airport_fee : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case vehicle = "vehicle"
        case image = "image"
        case status = "status"
        case no_of_bag = "no_of_bag"
        case date_time = "date_time"
        case base_fair = "base_fair"
        case per_hour = "per_hour"
        case per_minute = "per_minute"
        case per_minute_waiting_charge = "per_minute_waiting_charge"
        case rush_hour_start_time = "rush_hour_start_time"
        case rush_hour_end_time = "rush_hour_end_time"
        case rush_hour_price = "rush_hour_price"
        case per_km_price = "per_km_price"
        case type = "type"
        case no_of_passenger = "no_of_passenger"
        case list_order = "list_order"
        case timer_free_minute = "timer_free_minute"
        case each_minute_charge = "each_minute_charge"
        case stop_Timer_Free_Minute = "Stop_Timer_Free_Minute"
        case stop_Timer_Per_Min_Charge = "Stop_Timer_Per_Min_Charge"
        case hourly_rate = "hourly_rate"
        case driver_earning_percentage = "driver_earning_percentage"
        case no_show_fee = "no_show_fee"
        case cancelation_fee = "cancelation_fee"
        case booking_fee = "booking_fee"
        case web_Stop_Price = "Web_Stop_Price"
        case safety_fee = "safety_fee"
        case airport_fee = "airport_fee"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        vehicle = try values.decodeIfPresent(String.self, forKey: .vehicle)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        no_of_bag = try values.decodeIfPresent(String.self, forKey: .no_of_bag)
        date_time = try values.decodeIfPresent(String.self, forKey: .date_time)
        base_fair = try values.decodeIfPresent(String.self, forKey: .base_fair)
        per_hour = try values.decodeIfPresent(String.self, forKey: .per_hour)
        per_minute = try values.decodeIfPresent(String.self, forKey: .per_minute)
        per_minute_waiting_charge = try values.decodeIfPresent(String.self, forKey: .per_minute_waiting_charge)
        rush_hour_start_time = try values.decodeIfPresent(String.self, forKey: .rush_hour_start_time)
        rush_hour_end_time = try values.decodeIfPresent(String.self, forKey: .rush_hour_end_time)
        rush_hour_price = try values.decodeIfPresent(String.self, forKey: .rush_hour_price)
        per_km_price = try values.decodeIfPresent(String.self, forKey: .per_km_price)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        no_of_passenger = try values.decodeIfPresent(String.self, forKey: .no_of_passenger)
        list_order = try values.decodeIfPresent(String.self, forKey: .list_order)
        timer_free_minute = try values.decodeIfPresent(String.self, forKey: .timer_free_minute)
        each_minute_charge = try values.decodeIfPresent(String.self, forKey: .each_minute_charge)
        stop_Timer_Free_Minute = try values.decodeIfPresent(String.self, forKey: .stop_Timer_Free_Minute)
        stop_Timer_Per_Min_Charge = try values.decodeIfPresent(String.self, forKey: .stop_Timer_Per_Min_Charge)
        hourly_rate = try values.decodeIfPresent(String.self, forKey: .hourly_rate)
        driver_earning_percentage = try values.decodeIfPresent(String.self, forKey: .driver_earning_percentage)
        no_show_fee = try values.decodeIfPresent(String.self, forKey: .no_show_fee)
        cancelation_fee = try values.decodeIfPresent(String.self, forKey: .cancelation_fee)
        booking_fee = try values.decodeIfPresent(String.self, forKey: .booking_fee)
        web_Stop_Price = try values.decodeIfPresent(String.self, forKey: .web_Stop_Price)
        safety_fee = try values.decodeIfPresent(String.self, forKey: .safety_fee)
        airport_fee = try values.decodeIfPresent(String.self, forKey: .airport_fee)
    }

}
