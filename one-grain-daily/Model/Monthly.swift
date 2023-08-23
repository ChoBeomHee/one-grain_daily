//
//  Monthly.swift
//  one-grain-daily
//
//  Created by 김주현 on 2023/08/22.
//

import Foundation

struct Monthly: Codable {
    let comment: String
    let nickname: String
    let summery: String
}

struct Basket: Codable {
    let current_grain: Int
    //let max:Bool
    let max_grain: Int
   
}



