//
//  Api_Login.swift
//  GlisexabDriver
//
//  Created by Techimmense Software Solutions on 14/11/25.
//

import Foundation

struct Api_LoginResponse : Codable {
    let result : Res_LoginResponse?
    let message : String?
    let status : String?

    enum CodingKeys: String, CodingKey {

        case result = "result"
        case message = "message"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent(Res_LoginResponse.self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }

}

struct Res_LoginResponse : Codable {
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
    let total_earning : String?

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
        case total_earning = "total_earning"
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
        total_earning = try values.decodeIfPresent(String.self, forKey: .total_earning)
    }
}
