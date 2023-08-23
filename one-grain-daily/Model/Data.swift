//
//  Data.swift
//  one-grain-daily
//
//  Created by 김주현 on 2023/08/21.
// 구조체들 모음

import Foundation
import Alamofire
import SwiftUI

//사용자
struct Member: Codable, Identifiable {
    var member_id: Int? //아이디
    var email: String? //이메일
    var password: String? //비밀번호
    var name: String? //닉네임
    var role: String? //권한
    var created_at: String? //생성일자
    var modified_at: String? //수정일자

    enum CodingKeys: String, CodingKey {
        case member_id, email,password, name, role, created_at, modified_at
    }
    
    var id: Int? {
           return member_id
       }
}

// MARK: - UserInfo //GetUserInfo 시 사용
struct UserInfo: Codable {
    var currentGrainNum, donationGrainNum: Int
    var nickname, username: String

    enum CodingKeys: String, CodingKey {
        case currentGrainNum = "current_grain_num"
        case donationGrainNum = "donation_grain_num"
        case nickname, username
    }
}

//기부하기
struct Donate: Codable, Identifiable {
    var donation_list_id: Int? //아이디
    var donation_id: Int? //기부
    var memebr_id: Int? //기부한 사용자
  
    enum CodingKeys: String, CodingKey {
        case donation_list_id, donation_id, memebr_id
    }
    
    var id: Int? {
           return donation_list_id
       }
}

//기부
struct Donation: Codable, Identifiable {
    var donation_id: Int? //기부
    var status: String? //상태
    var image_url: String? //사진
    var created_at: Time?//생성일자
    var modified_at: Time? //수정일자
    var basket: Int? //바구니 수량
  
    enum CodingKeys: String, CodingKey {
        case donation_id,status,image_url,created_at,modified_at,basket
    }
    
    var id: Int? {
           return donation_id
       }
}


//쌀
struct Grain: Codable, Identifiable {
    var member_id: Int? //아이디
    var current_grain_num: Int? //현재 쌀 개수
    var donation_grain_num: Int? //기부한 쌀 개수
  
    enum CodingKeys: String, CodingKey {
        case member_id,current_grain_num, donation_grain_num
    }
    
    var id: Int? {
           return member_id
       }
}

