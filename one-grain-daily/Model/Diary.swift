//
//  Diary.swift
//  one-grain-daily
//
//  Created by 김주현 on 2023/08/21.
//  일기 기능

import Foundation
import Alamofire

// MARK: - Diary
struct Diary: Codable {
    let content: String
    let createTime: Time
    let emotion: Emotion
    let id: Int
    let title: String
}

// MARK: - Time //일자
struct Time: Codable {
    let date, hours, minutes, month: Int
    let nanos, seconds, time, year: Int
}

// MARK: - Emotion //감정
struct Emotion: Codable {
    let id: Int
    let image: String
    let month: Int
    let name: String
}

struct DiaryPost: Codable {
    
    var content: String
    var emotional: String
    var title: String

    enum CodingKeys: String, CodingKey {
        case content
        case emotional
        case title
    }
}


//delete diary
func diaryDelete(id: Int, completion: @escaping (Error?) -> Void) {
    let url = "http://115.85.183.243:8080/v1/user/deletePosting/\(id)"
    
    AF.request(url, method: .delete)
        .response { response in
            switch response.result {
            case .success:
                print("성공적으로 삭제됨")
                completion(nil)
            case .failure(let error):
                print("삭제 중 오류 발생")
                completion(error)
            }
        }
}

