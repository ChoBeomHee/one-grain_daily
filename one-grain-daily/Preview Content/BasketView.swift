//
//  BasketView.swift
//  one-grain-daily
//
//  Created by 김주현 on 2023/08/20.
//

import SwiftUI
import Alamofire

struct BasketView: View {
    @EnvironmentObject var userModel: UserModel
    @State private var current:Int = 8000
    @State private var max:Int = 10000
    
    var body: some View {
        
        VStack{
            Text("🧺 함께 모은 쌀 🧺")
                .font(.system(size:25))
                .fontWeight(.heavy)
            
            Spacer().frame(height: 50)

            Text("🍚")
                .font(.system(size: 170))
                .frame(height: 170)
            
            Spacer().frame(height: 50)
            
            Text("\(current) / \(max)")
                .font(.system(size:20))
                .fontWeight(.semibold)
            
            Spacer().frame(height: 40)
            
            VStack(alignment: .leading ) {
                Divider()
                Text("🥄 사람들이 공용 바구니에 모은 쌀을 확인할 수 있어요")
                    .font(.footnote)
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                
                Divider()
                
                Text("🥄 ( 모인 쌀알 개수 / 모아야 하는 쌀 개수 )")
                    .font(.footnote)
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                
                Divider()
                
                Text("🥄 10000개가 모이면 기부할 수 있어요!")
                    .font(.footnote)
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                Divider()
                
                Text("🥄 내가 기부한 쌀 개수는 MyPage에서 확인할 수 있어요")
                    .font(.footnote)
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                
                Divider()
                                
            }.padding()
        }.onAppear{
            
            getBasket2 { (basket, error) in
                if let basket = basket {
                    // 가져온 데이터를 사용하거나 처리합니다.
                    print("현재 쌀 양: \(basket.current_grain)")
                    print("최대 쌀 양: \(basket.max_grain)")
                } else if let error = error {
                    // 오류 처리
                    print("데이터 가져오기 오류: \(error.localizedDescription)")
                }
            }

        }
        
    }
    
    func getBasket(completion: @escaping (Basket?, Error?) -> Void) {
        let urlString = "http://115.85.183.243:8080/donations/basket"

        AF.request(urlString, method: .get, headers: ["Content-Type": "application/json", "Authorization": String(userModel.token)])
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase // JSON의 키가 snake_case인 경우
                        
                        let basket = try decoder.decode(Basket.self, from: data)
                        print("------Basket---------")
                        print(basket.current_grain)
                        
                        current = basket.current_grain
                        max = basket.max_grain
                        
                        
                        completion(basket, nil)
                        
                    } catch {
                        completion(nil, error)
                    }
                    
                case .failure(let error):
                    completion(nil, error)
                   
                }
            }
    }
    
    func getBasket2(completion: @escaping (Basket?, Error?) -> Void) {
        let urlString = "http://115.85.183.243:8080/donations/basket"
        AF.request(urlString, headers: ["Content-Type": "application/json", "Authorization": String(userModel.token)])
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    if let jsonDict = value as? [String: Any] {
                        print("----Received JSON data as Dictionary: current_grain & max_grain -------------")
                        print(jsonDict["current_grain"])
                        print(jsonDict["max_grain"])

                        let currentGrainNum = jsonDict["current_grain"] as? Int ?? 0
                        let maxGrainNum = jsonDict["max_grain"] as? Int ?? 0
                        
                        current = currentGrainNum
                        max = maxGrainNum

                    }

                case .failure(let error):
                    print("getBAsket2 Error") // 정보 출력
                    completion(nil, error)
                }
            }
    }
    


}

struct BasketView_Previews: PreviewProvider {
    static var previews: some View {
        BasketView()
    }
}
