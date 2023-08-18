//
//  Calander.swift
//  one-grain-daily
//
//  Created by 김주현 on 2023/08/18.
//

import SwiftUI

struct CalendarView: View {

    @State private var date = Date()


    var body: some View {
        DatePicker(
            "Start Date",
            selection: $date,
            displayedComponents: [.date]
        )
        .datePickerStyle(.graphical)
    }
}


struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
