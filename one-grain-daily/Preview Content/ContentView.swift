//
//  ContentView.swift
//  one-grain-daily
//
//  Created by 김주현 on 2023/08/18.
//

import SwiftUI

struct ContentView : View {
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
        DiaryView()
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
          
        Text("The Last Tab")
          .tabItem {
            Image(systemName: "gearshape.circle.fill")
            Text("환경설정") //환경설정
          }
          
    }
    .font(.headline)
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
