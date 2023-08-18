//
//  Calander.swift
//  one-grain-daily
//
//  Created by 김주현 on 2023/08/18.
//

import SwiftUI

struct CalendarView: View {

    @State private var date = Date()
    @State private var donate = 200
    @State private var have = 29


    var body: some View {
        
        VStack{
            DatePicker(
                "Start Date",
                selection: $date,
                displayedComponents: [.date]
            )
            .datePickerStyle(.graphical)
            Spacer().frame(height: 50)
            VStack{
                Text("기부한 쌀 : \(donate), 보유 쌀: \(have)")
            }
        }
        
    }
    
}


struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
