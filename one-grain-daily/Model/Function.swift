//
//  Function.swift
//  one-grain-daily
//
//  Created by 김주현 on 2023/08/22.
//

import Foundation

//한글인코딩함수
func makeStringKoreanEncoded(_ string: String) -> String {
    return string.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) ?? string
}
