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
          Text("일기")//달력
        }
      Text("Another Tab")
        .tabItem {
          Image(systemName: "basket.fill")
          Text("바구니") //바구니
        }
      Text("The Last Tab")
        .tabItem {
          Image(systemName: "plus")
        }
        .badge(10)
        Text("The Last Tab")
          .tabItem {
            Image(systemName: "4.square.fill")
            Text("Spoon")
          }
          
        Text("The Last Tab")
          .tabItem {
            Image(systemName: "gearshape.circle.fill")
            Text("Setting") //환경설정
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
