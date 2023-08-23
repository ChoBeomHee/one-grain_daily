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
    var iconName: String
    var date:String //작성날짜

    @State private var isEditingReview = false
    @State private var showDeleteAlert = false //일기를 삭제할건지 물어보는 알림

    var body: some View {
        
        VStack(alignment: .center) {
            HStack(alignment: .center) {
                Text("\(title)")
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                    .padding(10)
                    .background(Color.yellow)
                    .cornerRadius(10)
                
                HStack(spacing: 0) {
                   Text("")
                }
                .padding(.leading, 5)
                .padding(.trailing, 2)
                
              
            }
            
            HStack(alignment: .top){
                Text("\(date)")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .padding(5)
                    .padding(.top, 3)
                
                Spacer()
                
                HStack{
                    
                    //수정버튼 ->이후에 navigation link로 변경해야함.
                    Button(action: {
                        isEditingReview = true
                       
                    }, label: {
                        Image(systemName: "pencil")
                            .foregroundColor(.blue)
                    })
                    .padding(.trailing,2)

                    
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
                                //일기삭제함수
                            }),
                            secondaryButton: .cancel(Text("취소"), action: {})
                        )
                    })
                    .padding(.trailing,10)
                }
            }
            .padding(.leading, 5)
            
           
            
            
            Text(content)
                .font(.body)
                .padding(.leading, 5)
            
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
        .cornerRadius(5)
        .shadow(radius: 2, y: 1)
    }
}

