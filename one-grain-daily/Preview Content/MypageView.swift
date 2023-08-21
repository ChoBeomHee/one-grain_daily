//
//  MypageView.swift
//  one-grain-daily
//
//  Created by 김주현 on 2023/08/20.
//  개인정보창

import SwiftUI


class UserModel: ObservableObject {
    @State var username: String = ""
    @State var password: String = ""
    @State var nickname: String = ""
}


struct MypageView: View {
    @EnvironmentObject var userModel: UserModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var isLogoutActive = false
    @State var isLinkActive = false
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer().frame(height: 200)
            
//            CardView(title: "이름", value: userModel.username, iconName: "person")
//            CardView(title: "닉네임", value: userModel.nickname, iconName: "house")
            
            CardView(title: "이름", value: "김주현",iconName: "person")
            CardView(title: "닉네임", value: "양재주현", iconName: "house")
           
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
        .padding()
        .navigationBarTitle("My Page", displayMode: .inline)
    }
}

struct MypageView_Previews: PreviewProvider {
    static var previews: some View {
        MypageView()
    }
}


