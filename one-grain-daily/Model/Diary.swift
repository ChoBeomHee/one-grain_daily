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

//// 사용 예시
//getDiaryData(forDate: "2023-08-20") { diaryData, error in
//    if let diaryData = diaryData {
//        // Diary 구조체에서 title과 content를 추출하여 표시
//        let title = diaryData.title
//        let content = diaryData.content
//        print("제목: \(title)")
//        print("내용: \(content)")
//    } else if let error = error {
//        // 오류 처리
//        print("오류: \(error)")
//    }
//}


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
