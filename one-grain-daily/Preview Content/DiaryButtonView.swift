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
                
                Image(systemName: "pencil.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                Spacer().frame(height: 30)
                
                Text("일기 쓰기")
            }
            
            
        }
    }
}

struct DiaryButtonView_Previews: PreviewProvider {
    static var previews: some View {
        DiaryButtonView()
    }
}
