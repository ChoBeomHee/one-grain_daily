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
      Text("The First Tab")
        .tabItem {
          Image(systemName: "1.square.fill")
          Text("First")
        }
      Text("Another Tab")
        .tabItem {
          Image(systemName: "2.square.fill")
          Text("Second")
        }
      Text("The Last Tab")
        .tabItem {
          Image(systemName: "3.square.fill")
          Text("Third")
        }
        .badge(10)
    }
    .font(.headline)
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
