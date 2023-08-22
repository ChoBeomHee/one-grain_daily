//
//  Calander.swift
//  one-grain-daily
//
//  Created by 김주현 on 2023/08/18.
//

import SwiftUI
import Alamofire

struct Memo: Identifiable {
    let id = UUID()
    let date: Date
    var text: String
}

struct CalendarView: View {
    @State private var date = Date()
    @State private var memoText = ""
    @State private var memos: [Memo] = []
    
    @State private var donate = 200
    @State private var have = 29

    var filteredMemos: [Memo] {
        return memos.filter { Calendar.current.isDate($0.date, inSameDayAs: date) }
    }

    var body: some View {
        VStack {
            DatePicker(
                "Start Date",
                selection: $date,
                displayedComponents: [.date]
            )
            .datePickerStyle(.graphical)
            
            VStack{
                Text("기부한 쌀 : \(donate), 보유 쌀: \(have)")
            }

            
            TextField("메모 추가", text: $memoText)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button("메모 저장") {
                saveMemo()
            }
            
            List(filteredMemos) { memo in
                Text("\(memo.date, formatter: dateFormatter): \(memo.text)")
            }
        }
    }
    
    private func saveMemo() {
        memos.append(Memo(date: date, text: memoText))
        memoText = ""
    }
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        return formatter
    }()
}


struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
