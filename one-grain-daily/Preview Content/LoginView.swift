//
//  LoginView.swift
//  one-grain-daily
//
//  Created by 김주현 on 2023/08/20.
//


import SwiftUI
import Alamofire

class UserModel: ObservableObject {
    @Published var token: String = ""
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var nickname: String = ""
}

struct LoginView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var showingAlert = false
    @State var uiTabarController: UITabBarController?
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var nickname: String = ""
    
    @State private var isLoggedIn = false //로그인 성공여부
    @EnvironmentObject var userModel: UserModel //로그인 성공 시 사용자 정보를 저장할 환경변수

    
    var body: some View {
        NavigationView{
            VStack{
                HStack{
                    Spacer()
                    Image("redString") // 적십자 이미지 추가
                        .resizable()
                        .scaledToFit()
                        .frame(width: 180, height: 180)
                        .padding()
                    Spacer()
                    
                }
                
                Text("적십자와 함께하는 \"하루 한 톨\" ") // 문구 추가
                    .font(.system(size:20))
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    
                Image("rice2")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 150)
                                
                                
                Text("LOGIN")
                    .font(.title)
                    .fontWeight(.heavy)
                    .padding().frame(height:100)
                    .foregroundColor(.black)
                HStack{
                    Spacer().frame(width: 20)
                    Image(systemName: "person.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .padding(.bottom)
                    
                    TextField("아이디를 입력하세요.", text: $username)
                        .frame(width: 270, height: 10)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(5.0)
                        .padding(.bottom, 20)
                    Spacer().frame(width: 20)
                }
                                
                HStack{
                    Spacer().frame(width: 20)
                    Image(systemName: "lock")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .padding(.bottom)
                        
                    SecureField("비밀번호를 입력하세요", text: $password)
                        .frame(width: 270, height: 10)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(5.0)
                        .padding(.bottom, 20)
                    Spacer().frame(width: 20)
                }
                
                //로그인 성공하면 메인 페이지로
                NavigationLink(destination: ContentView(), isActive: $isLoggedIn){
                    EmptyView()
                }
                HStack{
                    
                    //로그인 버튼
                    Button(action: {
                        
                        //------로그인 성공 로직
                        self.isLoggedIn = true //로그인 성공하면 true로
                        
                        print(self.username + self.password + self.nickname)
                   
                        
                        loginAndFetchHeaders(username: self.username, password: self.password) { authorizationHeader in
                            if let authorizationHeader = authorizationHeader {
                                // 로그인 성공 및 Authorization 헤더가 있을 때
                                print("Authorization Header:", authorizationHeader)
                                userModel.token = authorizationHeader
                                userModel.username = self.username

                                // 여기에서 저장하거나 사용할 수 있음
                            } else {
                                // 로그인 실패 또는 Authorization 헤더가 없을 때
                                print("로그인 실패 또는 Authorization 헤더 없음")
                            }
                        }


                        
                        
                    }){
                        Text("로그인")
                            .frame(width: 80, height: 10)
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color(.orange))
                            .cornerRadius(10)
                            
                    }

                    .padding()
                    .onSubmit {
                        
                    }
                    NavigationLink(destination: SignUpView()){
                        
                        Text("회원가입")
                            .frame(width: 80, height: 10)
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color(.orange))
                            .cornerRadius(10)
                    }
                    
                }
                
                Spacer()
            }
            .padding(.all, 30)
            .navigationBarBackButtonHidden(true)
        }
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
