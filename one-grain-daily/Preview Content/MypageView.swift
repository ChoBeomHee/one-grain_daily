//
//  MypageView.swift
//  one-grain-daily
//
//  Created by 김주현 on 2023/08/20.
//  개인정보창

import SwiftUI
import Alamofire


struct MypageView: View {
    @EnvironmentObject var userModel: UserModel
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var isLogoutActive = false
    @State var isLinkActive = false
    
    @State private var userInfo: UserInfo? = nil
    @State private var error: Error? = nil
    
    var body: some View {
        ScrollView{
            VStack(spacing: 20) {
                
                VStack{
                    Spacer().frame(height: 50)
                    Image(systemName: "person")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                    
                    Text("My page")
                        .font(.title)
                        .fontWeight(.heavy)
                        .padding().frame(height:50)
                        .foregroundColor(.black)
                }
                
                if let userInfo = userInfo {
                    
                    HStack{
                        
                        CardView3(title: "현재 쌀 개수", value: String("\(userInfo.currentGrainNum) 개"), iconName: "heart")
                        CardView3(title: "기부한 쌀 개수", value: String("\(userInfo.donationGrainNum) 개"), iconName: "heart.fill")
                    }

                    CardView(title: "이름", value: userModel.username, iconName: "person")
                    CardView2(value: "앱 정보", iconName: "rectangle.and.text.magnifyingglass")
                    CardView2(value: "이용약관", iconName: "rectangle.and.text.magnifyingglass")
                    
                } else if let error = error {
                    Text("오류: \(error.localizedDescription)")
                } else {
                    Text("로딩 중...")
                }
                
                
                Spacer().frame(height: 2)
                
               
                // 로그아웃 버튼
                Button(action: {
                    // navigation stack 제거
                    isLogoutActive = true
                    // 모든 네비게이션 스택을 제거하고 root view로 돌아갑니다.
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("로그아웃")
                        .foregroundColor(.blue)
                }.fullScreenCover(isPresented: $isLogoutActive) {
                    LoginView()
                }
                
                
                Spacer()
            }
        }
        
        
        .padding()
        .navigationBarTitle("My Page", displayMode: .inline)
        .onAppear {
            Task {
                do {
                        let (userInfo, error) = try await withUnsafeThrowingContinuation { continuation in
                            getUserInfo { userInfo, error in
                                continuation.resume(returning: (userInfo, error))
                            }
                        }
                        
                        if let userInfo = userInfo {
                            // Handle userInfo
        
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
    
    func getUserInfo(completion: @escaping (UserInfo?, Error?) -> Void) {
        let urlString = "http://115.85.183.243:8080/api/v1/user/getUserInfo"
        AF.request(urlString, headers: ["Content-Type": "application/json", "Authorization": String(userModel.token)])
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    if let jsonDict = value as? [String: Any] {
                        print("----Received JSON data as Dictionary:")
                        print(jsonDict["username"])

                        let nickname = jsonDict["nickname"] as? String ?? ""
                        let username = jsonDict["username"] as? String ?? ""
                        let currentGrainNum = jsonDict["current_grain_num"] as? Int ?? 0
                        let donationGrainNum = jsonDict["donation_grain_num"] as? Int ?? 0

                        let receivedUserInfo = UserInfo(
                            currentGrainNum: currentGrainNum,
                            donationGrainNum: donationGrainNum,
                            nickname: nickname,
                            username: username
                        )

                        userInfo = receivedUserInfo
                    }

                    print("----------- UserInfo: ")
                    print(value.self) // 정보 출력
                case .failure(let error):
                    print("----------- UserInfo: \(userInfo?.username)") // 정보 출력
                    completion(nil, error)
                }
            }
    }
}

struct MypageView_Previews: PreviewProvider {
    static var previews: some View {
        MypageView()
    }
}


