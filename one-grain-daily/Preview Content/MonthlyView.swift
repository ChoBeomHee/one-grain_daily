//
//  MonthlyView.swift
//  one-grain-daily
//
//  Created by 김주현 on 2023/08/20.
//

import SwiftUI
import Alamofire

struct MonthlyView: View {
    @EnvironmentObject var userModel: UserModel
    
    @State private var month: Int = 8
    @State private var username: String = "주현"
    @State private var rice: String = "흰쌀밥"
    @State private var comment: String = "이번 한 달도 고생 많으셨어요!\n이번달은 대체로 좋은 추억이 많았던 만큼\n 좋은 추억 잘 간직하셨으면 좋겠습니다 :)"
    
    var body: some View {
        
        
        VStack{
            Text(" 🥄 한 달 한 숟")
                .font(.title)
                .fontWeight(.heavy)
                .padding().frame(height:110)
                .foregroundColor(.black)
            
            Text("\(username)님의 \(month)월은 \(rice)입니다.")
                .font(.title2)
                .fontWeight(.bold)
            
            Image("rice2")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 300)
            
            //Text("\(comment)")
            
            CuteCardView(message: comment)
        }
    }
}

struct MonthlyView_Previews: PreviewProvider {
    static var previews: some View {
        MonthlyView()
    }
}


struct CuteCardView: View {
    var message: String
    
    var body: some View {
        VStack(alignment: .leading) {

            Text("💌 \(message)")
                .font(.system(size: 19))
                .fontWeight(.bold)
                .padding(23)
                .foregroundColor(.white)
                .background(Color.orange)
                .cornerRadius(15)
                .shadow(radius: 5)
        }
        .padding()
    }
}

struct CuteCardView_Previews: PreviewProvider {
    static var previews: some View {
        CuteCardView(message: "안녕하세요!")
            .previewLayout(.sizeThatFits)
    }
}
