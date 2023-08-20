//
//  LoginView.swift
//  one-grain-daily
//
//  Created by 김주현 on 2023/08/20.
//



import SwiftUI

struct LoginView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var loginStatus: Bool = false // TODO env 변수로 선언 후 토큰 계속 확인
    @State private var userAccessToken: String = ""
    
    
    var body: some View {
        
        NavigationView{
            if self.loginStatus != false {
//                ProfileDetail(userEmail: self.email, userAccessToken: self.userAccessToken)
            } else {
                VStack{
                    Text("하루 한 톨")
                        .font(.title)
                        .fontWeight(.heavy)
                        .padding().frame(height:100)
                        .foregroundColor(.black)
                    HStack{
                        
                        TextField("ID를 입력하세요.", text: $email)
                            .frame(width: 300, height: 20)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(5.0)
                            .padding(.bottom, 20)
                            
                    }
                    HStack{
                            
                        SecureField("비밀번호를 입력하세요", text: $password)
                            .frame(width: 300, height: 20)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(5.0)
                            .padding(.bottom, 20)
                    }
                    
                    HStack{
                        Button(action: {
//                            print(self.email + self.password)
//
//                            let rft = readItemKeyChain(userId: self.email)
//                            if rft != nil {
//                                UserDefaults.standard.set(rft, forKey: self.email)
//                            }else{
//                                sendPostRequest("<http://localhost:8000/auth/login>", parameters: ["username": self.email, "password": self.password]){
//                                    responseObject, error in guard let _ = responseObject, error == nil else {
//                                        print(error ?? "Unknown error")
//                                        return
//                                    }
//                                    self.loginStatus = true
//
//                                    if let rftToken = responseObject{
//                                        let rft = rftToken["refresh"] as? String
//                                        self.userAccessToken = rftToken["access"] as? String ?? ""
//                                        setItemKeyChain(userId: self.email, rft: rft!)
//                                        UserDefaults.standard.set(rft, forKey: self.email)
//                                    }
//                                }
//                            }
                        }){
                            NavigationLink(destination: ContentView()){
                                Text("로그인")
                                    .frame(width: 100, height: 20)
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color(.systemBlue))
                                    .cornerRadius(5)
                            }
                                
                        }
                        .padding()
                        
                        NavigationLink(destination: SignUpView()){
                            Text("회원가입")
                                .frame(width: 100, height: 20)
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color(.systemBlue))
                                .cornerRadius(5)
                        }
                        
                        
                    }
                    
                }
                .padding(.all, 30)
                .navigationBarTitle("", displayMode: .inline)
                .navigationBarHidden(true)
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
