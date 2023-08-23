//
//  DiaryCardView.swift
//  one-grain-daily
//
//  Created by 김주현 on 2023/08/23.
//

import SwiftUI

struct DiaryCardView: View {
    @EnvironmentObject var userModel: UserModel
    var title: String
    var content: String
    var emotion: String
    var date:String //작성날짜
    var id: Int //일기 번호

    @State private var isEditingReview = false
    @State private var showDeleteAlert = false //일기를 삭제할건지 물어보는 알림
    
    let emotion_dict = ["happy": "😄", "sad": "😢", "angry": "😡", "sick": "😷", "tired": "🥱", "sleepy": "😴" ]
    
    var emotion2: String {
            switch emotion {
            case "happy":
                return "😄"
            case "sad":
                return "😢"
            case "angry":
                return "😡"
    
            default:
                return "😄" // 기본값
            }
        }

    var body: some View {
        
        VStack(alignment: .center) {
            HStack(alignment: .center) {
                Text(emotion2)
                    .font(.system(size: 33))
                    .frame(height: 33)
                    .padding(.leading, 5)
                    .padding(.trailing, 2)
                
                Spacer()
                
                Text("\(title)")
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                    .padding(10)
                    .background(Color.yellow)
                    .cornerRadius(10)
                Spacer()
                
                HStack{
                    
                    // 삭제버튼
                    Button(action: {
                        showDeleteAlert = true //삭제버튼을 누르면 "일기를 삭제하시겠습니까?" 알림이 활성화됨.
                        
                    }, label: {
                        Image(systemName: "trash")
                            .foregroundColor(.red)
                    })
                    .alert(isPresented: $showDeleteAlert, content: {
                        
                        Alert(
                            title: Text("확인"),
                            message: Text("일기를 삭제하시겠습니까?"),
                            primaryButton: .default(Text("삭제"), action: {
                                
                                diaryDelete(id: id, auth: userModel.token ) { error in
                                    if let error = error {
                                        // 오류 처리
                                        print("DELETE 요청 실패: \(error.localizedDescription)")
                                    } else {
                                        // DELETE 요청 성공
                                        print("DELETE 요청 성공")
                                    }
                                }

                            }),
                            secondaryButton: .cancel(Text("취소"), action: {})
                        )
                    })
                    .padding(.trailing,10)
                }
              
            }
            
            Spacer().frame(height: 20)
            
            Divider()
            HStack(alignment: .top){
                Text("작성일 : \(date)")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .padding(5)
                    .padding(.top, 3)
                
                Spacer()
                
            }
            .padding(.leading, 5)
            
            Divider()
            Spacer().frame(height: 20)
           
            HStack{
                
                Text(content)
                    .font(.body)
                    .padding(.leading, 5)
                Spacer()
            }.padding(.leading, 5)
            
            
            
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
        .cornerRadius(5)
        .shadow(radius: 2, y: 1)
    }
}
