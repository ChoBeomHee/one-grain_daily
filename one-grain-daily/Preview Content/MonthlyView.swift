//
//  MonthlyView.swift
//  one-grain-daily
//
//  Created by 김주현 on 2023/08/20.
//

import SwiftUI
import Alamofire
//http://115.85.183.243:8080/api/v1/user/monthreview/\(month)

struct MonthlyView: View {

    @EnvironmentObject var userModel: UserModel
    @State private var selectedYear = Calendar.current.component(.year, from: Date())
    @State private var selectedMonth = Calendar.current.component(.month, from: Date())
    
    @State private var month: Int = 8
    @State private var username: String = "주현"
    @State private var rice: String = "흰쌀밥"
    @State private var comment: String = "이번 한 달도 고생 많으셨어요!\n이번달은 대체로 좋은 추억이 많았던 만큼\n 좋은 추억 잘 간직하셨으면 좋겠습니다 :)"
    
    var body: some View {
        
        ScrollView(){
            VStack{

                Text(" 🥄 한 달 한 숟")
                    .font(.title)
                    .fontWeight(.heavy)
                    .padding().frame(height:90)
                    .foregroundColor(.black)
                
                HStack { //픽커
                    Picker("년도", selection: $selectedYear) {
                        ForEach(1900..<2101, id: \.self) { year in
                            Text("\(year)년").tag(year)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    
                    Picker("월", selection: $selectedMonth) {
                        ForEach(1..<13, id: \.self) { month in
                            Text("\(month)월").tag(month)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                }
                .frame(height: 100) // YearMonthPicker의 높이를 조절
                .padding(.horizontal, 20) // 좌우 여백 추가
                .onReceive([self.selectedMonth].publisher.first()) { _ in
                    // selectedMonth 값이 변경될 때마다 호출
                    getMonthReview(month: selectedMonth) { monthly, error in
                        if let monthly = monthly {
                            // Monthly 모델을 사용하여 필요한 작업 수행
                            // 예: self.username = monthly.nickname
                        } else if let error = error {
                            // 에러 처리
                            print("에러 발생: \(error.localizedDescription)")
                        }
                    }
                }
                
                Text("\(username)님의 \(selectedMonth)월은 \(rice)입니다.")
                    .font(.title2)
                    .fontWeight(.bold)
                
                
                
                Image("rice2")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 300)
                
                
                CuteCardView(message: comment)
                

                
                
            }

            }
        }
        
    
    func getMonthReview(month: Int, completion: @escaping (Monthly?, Error?) -> Void) {
        let urlString = "http://115.85.183.243:8080/api/v1/user/monthreview/\(month)"
        
        AF.request(urlString, headers: ["Content-Type": "application/json", "Authorization": String(userModel.token)])
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase // JSON의 키가 snake_case인 경우
                        
                        let monthly = try decoder.decode(Monthly.self, from: data)
                        print("---------------")
                        print(monthly.comment)
                        print(monthly.nickname)
                        print(monthly.summery)
                        
                        username = monthly.nickname
                        comment = monthly.comment
                        rice = monthly.summery

                        completion(monthly, nil)

                        
                    } catch {
                        completion(nil, error)
                       
                    }
                    
                case .failure(let error):
                    completion(nil, error)
                  
                }
            }
    }
}

struct YearMonthPicker: View {
    @Binding var selectedYear: Int
    @Binding var selectedMonth: Int
    @EnvironmentObject var userModel: UserModel
    var body: some View {
        HStack {
            Picker("년도", selection: $selectedYear) {
                ForEach(1900..<2101, id: \.self) { year in
                    Text("\(year)년").tag(year)
                }
            }
            .pickerStyle(WheelPickerStyle())
            
            Picker("월", selection: $selectedMonth) {
                ForEach(1..<13, id: \.self) { month in
                    Text("\(month)월").tag(month)
                }
            }
            .pickerStyle(WheelPickerStyle())
        }
        .onReceive([self.selectedMonth].publisher.first()) { _ in
            // selectedMonth 값이 변경될 때마다 호출
            getMonthReview(month: selectedMonth) { monthly, error in
                if let monthly = monthly {
                    // Monthly 모델을 사용하여 필요한 작업 수행
                    // 예: self.username = monthly.nickname
                } else if let error = error {
                    // 에러 처리
                    print("에러 발생: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func getMonthReview(month: Int, completion: @escaping (Monthly?, Error?) -> Void) {
        let urlString = "http://115.85.183.243:8080/api/v1/user/monthreview/\(month)"
        
        AF.request(urlString, headers: ["Content-Type": "application/json", "Authorization": String(userModel.token)])
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase // JSON의 키가 snake_case인 경우
                        
                        let monthly = try decoder.decode(Monthly.self, from: data)
                        print("---------------")
                        print(monthly.comment)
                        print(monthly.nickname)
                        print(monthly.summery)

                        completion(monthly, nil)

                        
                    } catch {
                        completion(nil, error)
                       
                    }
                    
                case .failure(let error):
                    completion(nil, error)
                  
                }
            }
    }
}



struct MonthlyView_Previews: PreviewProvider {
    static var previews: some View {
        MonthlyView()
    }
}


struct CuteCardView: View {
    var message: String
    
    var body: some View {
        VStack(alignment: .leading) {

            Text("💌 \(message)")
                .font(.system(size: 19))
                .fontWeight(.bold)
                .padding(23)
                .foregroundColor(.white)
                .background(Color.orange)
                .cornerRadius(15)
                .shadow(radius: 5)
        }
        .padding()
    }
}

//struct CuteCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        CuteCardView(message: "안녕하세요!")
//            .previewLayout(.sizeThatFits)
//    }
//}
