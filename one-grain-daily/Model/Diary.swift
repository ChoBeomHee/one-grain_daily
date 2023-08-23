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
    let emotion: Emotion
    let title: String
    let id: Int
    // Add any other properties you need
}

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


//날짜를 받아서 해당 날짜에 해당하는 일기를 get
func getDiaryData(forDate date: String, completion: @escaping (Diary?, Error?) -> Void) {
    let urlString = "http://115.85.183.243:8080/api/v1/user/getDiary/\(date)"
    
    AF.request(urlString).responseDecodable(of: Diary.self) { response in
        switch response.result {
        case .success(let diaryData):
            completion(diaryData, nil)
        case .failure(let error):
            completion(nil, error)
        }
    }
}


func deletePosting(id: Int, auth: String, completion: @escaping (Error?) -> Void) {
    let urlString = "http://115.85.183.243:8080​/api​/v1​/user​/deletePosting​/\(id)"
    
    
    AF.request(urlString, method: .delete)
        .validate()
        .response { response in
            switch response.result {
            case .success:
                // DELETE 요청이 성공적으로 완료됨
                completion(nil)
            case .failure(let error):
                // 오류가 발생함
                completion(error)
            }
        }
}


func diaryDelete(id: Int, auth: String,  completion: @escaping (Error?) -> Void) {
    let url = "http://115.85.183.243:8080​/api​/v1​/user​/deletePosting​/\(id)"
    
    // 헤더 설정
    let headers: HTTPHeaders = [
            "Authorization": "\(auth)", // 필요한 경우 토큰 또는 다른 인증 정보로 교체
            "Content-Type": "application/json" // 필요한 헤더 추가
        ]
    
    AF.request(url, method: .delete, headers: headers)
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




//날짜데이터 형식의 String을 원하는 형식으로 변환
func convertDate(from string: String) -> String {
    let inputFormatter = DateFormatter()
    inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    if let date = inputFormatter.date(from: string) {
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "yyyy.MM.dd"
        return outputFormatter.string(from: date)
    } else {
        return "Invalid date"
    }
}
