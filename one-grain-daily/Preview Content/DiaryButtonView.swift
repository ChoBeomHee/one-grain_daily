//
//  DiaryButtonView.swift
//  one-grain-daily
//
//  Created by 김주현 on 2023/08/22.
//

import SwiftUI

struct DiaryButtonView: View {
    var body: some View {
        
        NavigationLink(destination: DiaryView()){
            
            VStack{
                
                
                Image("diary")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 110, height: 110)
                
                Spacer().frame(height: 22)
                
                Text("일기 쓰고 쌀알 얻기")
                    .font(.system(size: 20, weight: .bold, design: .rounded)) // 사이즈, 굵기, 디자인을 설정
                    .foregroundColor(.gray) // 글자색 지정
                
            }
            
        }
    }
}

struct DiaryButtonView_Previews: PreviewProvider {
    static var previews: some View {
        DiaryButtonView()
    }
}

//            let comment:String = "오늘 느꼈던 감정이나 있었던 일들을 기록하면 쌀을 하나 얻을 수 있습니다.\n한 달 동안 쓴 일기를 기반으로 나의 감정이 흰쌀밥, 흑미, 잡곡밥 등으로 표시됩니다."
//
//            CuteCardView(message: comment)
            
//            Text("오늘 느꼈던 감정이나 있었던 일들을 기록하면 쌀을 하나 얻을 수 있습니다.")
//            Text("한 달 동안 쓴 일기를 기반으로 나의 감정이 흰쌀밥, 흑미, 잡곡밥 등으로 표시됩니다. ")
