//
//  Calander.swift
//  one-grain-daily
//
//  Created by 김주현 on 2023/08/18.
//

import SwiftUI
import Alamofire

struct CalendarView: View {
    @EnvironmentObject var userModel: UserModel
    @State private var diary: Diary? // Diary 모델을 저장할 상태 변수
    
    //서버에서 받아올 일기내용
    @State private var content: String = ""
    @State private var emotion_name: String = ""
    @State private var title: String = ""
    
    @State private var date = Date()
    @State private var dateString: String = ""

    @State private var donate = 200
    @State private var have = 29



    var body: some View {
        ScrollView{
            VStack(spacing: 10) {
                Text("🗓️ Calander")
                    .font(.title)
                    .fontWeight(.heavy)
                
                    .foregroundColor(.black)
                DatePicker(
                    "Start Date",
                    selection: $date,
                    displayedComponents: [.date]
                )
                .datePickerStyle(.graphical)
                .onChange(of: date) { newValue in
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd" // 날짜 형식을 지정합니다
                    dateString = dateFormatter.string(from: newValue)
                    
                    getDiary(date: dateString) { (diary, error) in
                        if let error = error {
                            // 에러 처리
                            print("에러 발생: \(error.localizedDescription)")
                        } else if let diary = diary {
                            // 일기 정보 처리
                            // ...
                        }
                    }
                }
            
                
                VStack{
                    Text("기부한 쌀 : \(donate), 보유 쌀: \(have)")
                }
                
                VStack(spacing: 20) {
                    //서버에서 받아온 내용을 표시하도록 바꿔야됨.
                    let content: String = "오늘은 프론트엔드 개발을 했다.재밌었다.오늘은 프론트엔드 개발을 했다.재밌었다.오늘은 프론트엔드 개발을 했다.재밌었다.오늘은 프론트엔드 개발을 했다.재밌었다.오늘은 프론트엔드 개발을 했다.재밌었다.오늘은 프론트엔드 개발을 했다.재밌었다."

                    DiaryCardView(title: "오늘의 일기", content: content, iconName: "person", date: dateString)

                }.padding(13)

                
    
            }
            .padding(13)
                .onAppear {
                    
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd" // 날짜 형식을 지정합니다
                    dateString = dateFormatter.string(from: date)
                
                Task {
                    do {
                            let (diary, error) = try await withUnsafeThrowingContinuation { continuation in
                                getDiary(date: dateString) { diary, error in
                                    continuation.resume(returning: (diary, error))
                                }
                            }
                            
                            if let diary = diary {
            
                            } else if let error = error {
                                // Handle error
                                print("오류: \(error.localizedDescription)")
                            }
                        } catch {
                            // Handle any other error
                            print("오류: \(error.localizedDescription)")
                        }
                }
        
            }
        }
        
    }
    
    func getDiary(date: String, completion: @escaping (Diary?, Error?) -> Void) {
        let urlString = "http://115.85.183.243:8080/api/v1/user/getDiary/\(date)"
        
        AF.request(urlString, headers: ["Content-Type": "application/json", "Authorization": String(userModel.token)])
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase // JSON의 키가 snake_case인 경우
                        print(decoder)
                        
                        let diary = try decoder.decode(Diary.self, from: data)
                        print("---------------")
                        print(diary.content)
                        print(diary.emotion.name)
                        print(diary.title)
                        completion(diary, nil)
                    } catch {
                        completion(nil, error)
                    }
                    
                case .failure(let error):
                    completion(nil, error)
                }
            }
    }

    
    
    
//    func getDiary(date: String, completion: @escaping (Diary?, Error?) -> Void) {
//        let urlString = "http://115.85.183.243:8080/api/v1/user/getDiary/\(date)"
//        print("date가 잘 들어가지나요 ??? ----------",date)
//        AF.request(urlString, headers: ["Content-Type": "application/json", "Authorization": String(userModel.token)])
//            .responseJSON { response in
//                switch response.result {
//                case .success(let value):
//                    if let jsonDict = value as? [String: Any] {
//                        print("----Received JSON data as Dictionary:")
//                        print("--------- 받아지나?????? ------------")
//                        print(response)
//
//                        let content2 = jsonDict["content"] as? String ?? ""
//                        let emotion_structure = jsonDict["emotion"] as? Emotion ?? nil
//                        let title2 = jsonDict["title"] as? String ?? ""
//
//                        content = content2
//                        emotion_name = emotion_structure?.name ?? ""
//                        title = title2
//                    }
//
//                case .failure(let error):
//                    //print("----------- UserInfo: \(userInfo?.username)") // 정보 출력
//                    completion(nil, error)
//                }
//            }
//    }
    
    
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        return formatter
    }()
}


struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
