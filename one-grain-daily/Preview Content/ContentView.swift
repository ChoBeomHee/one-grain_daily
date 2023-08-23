//
//  ContentView.swift
//  one-grain-daily
//
//  Created by 김주현 on 2023/08/18.
//  app의  Main Page

import SwiftUI
import Alamofire

struct ContentView : View {
    @EnvironmentObject var userModel: UserModel
  var body: some View {
    TabView {
        CalendarView()
        .tabItem {
          Image(systemName: "calendar")
          Text("달력")//달력
        }
        BasketView()
        .tabItem {
          Image(systemName: "basket.fill")
          Text("바구니") //바구니
        }
        DiaryButtonView()
        .tabItem {
          Image(systemName: "plus")
            Text("일기쓰기")
        }
        .badge(10)
        MonthlyView()
          .tabItem {
            Image(systemName: "cup.and.saucer.fill")
            Text("한 달 한 숟")
          }
         
        //UserInfoView()
        MypageView()        
          .tabItem {
            Image(systemName: "person")
            Text("My page") //환경설정
          }
          .environmentObject(userModel)
          
    }
    .font(.headline)
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
