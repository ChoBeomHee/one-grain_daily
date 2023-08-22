//
//  LoginView.swift
//  one-grain-daily
//
//  Created by 김주현 on 2023/08/20.
//


import SwiftUI
import Alamofire

struct LoginView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var showingAlert = false
    @State var uiTabarController: UITabBarController?
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var nickname: String = ""
    
    @State private var isLoggedIn = false //로그인 성공여부


    
    var body: some View {
        NavigationView{
            VStack{
                Text("로그인")
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

                        sendPostRequest("http://115.85.183.243:8080/login", parameters: ["username": self.username, "password": self.password]) { responseObject, error in
                            if let responseObject = responseObject {
                                // 서버 응답을 이용한 원하는 작업 수행
                                
                                print("서버 응답:", responseObject)
                            } else if let error = error {
                                // 오류 처리
                                print("오류:", error)
                                
                            } else {
                                // 그 외의 예외 상황 처리
                                print("알 수 없는 오류")
                                
                            }
                        }
                       
                        loginAndFetchHeaders(username: self.username, password: self.password)

                        //self.presentationMode.wrappedValue.dismiss()
                        
                        
                        
                    }){
                        Text("로그인")
                            .frame(width: 80, height: 10)
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color(.systemBlue))
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
                            .background(Color(.systemBlue))
                            .cornerRadius(10)
                    }
                    
                }
                
                
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
