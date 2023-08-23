//
//  UserInfoView.swift
//  one-grain-daily
//
//  Created by 김주현 on 2023/08/22.
//

import SwiftUI
import Alamofire

struct UserInfoView: View {
    @State private var userInfo: UserInfo? = nil
    @State private var error: Error? = nil
    
    @EnvironmentObject var userModel: UserModel

    var body: some View {
        VStack {
            if let userInfo = userInfo {
                Text("닉네임: \(userInfo.nickname)")
                Text("유저네임: \(userInfo.username)")
                Text("현재 Grain 수: \(userInfo.currentGrainNum)")
                Text("기부한 Grain 수: \(userInfo.donationGrainNum)")
            } else if let error = error {
                Text("오류: \(error.localizedDescription)")
            } else {
                Text("로딩 중...")
            }
        }
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

struct UserInfoView_Previews: PreviewProvider {
    static var previews: some View {
        UserInfoView()
    }
}
