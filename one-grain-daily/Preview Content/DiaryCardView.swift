//
//  DiaryCardView.swift
//  one-grain-daily
//
//  Created by 김주현 on 2023/08/23.
//

import SwiftUI

struct DiaryCardView: View {
    var title: String
    var value: String
    var iconName: String

    var body: some View {
        HStack {
            Image(systemName: iconName)
                .foregroundColor(.blue)
                .imageScale(.large)
                .padding(.horizontal)
            VStack(alignment: .leading) {
                Text(title)
                    .font(.footnote)
                    .foregroundColor(Color.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 15)
                    .padding(.bottom, 3)
                
                Text(value)
                    .font(.subheadline)
                    .fontWeight(.regular)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)
                    .lineLimit(nil)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 15)
            }
        }
        .frame(minHeight: 60)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: .gray, radius: 2, x: 0, y: 2)
        .padding(.leading, 3)
        .padding(.leading, 3)
        .padding(.bottom, 2)
    }
}

struct DiaryCardView_Previews: PreviewProvider {
    static var previews: some View {
        let content: String = "오늘은 프론트엔드 개발을 했다.재밌었다.오늘은 프론트엔드 개발을 했다.재밌었다.오늘은 프론트엔드 개발을 했다.재밌었다.오늘은 프론트엔드 개발을 했다.재밌었다.오늘은 프론트엔드 개발을 했다.재밌었다.오늘은 프론트엔드 개발을 했다.재밌었다."
        DiaryCardView(title: "오늘의 일기", value: content, iconName: "person")
    }
}
