//
//  VerifyMobileNumber.swift
//  GlisexabDriver
//
//  Created by Arbaz  on 12/01/26.
//

import Foundation

struct Api_VerifyEmail : Codable {
    
    let code : Int?
    let result : String?
    let message : String?
    let status : String?

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case result = "result"
        case message = "message"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = try values.decodeIfPresent(Int.self, forKey: .code)
        result = try values.decodeIfPresent(String.self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
}
