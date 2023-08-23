//
//  TestView.swift
//  one-grain-daily
//
//  Created by 김주현 on 2023/08/22.
//

import SwiftUI

struct TestView: View {
    @State private var selectedDate: String = ""
    @State private var diaryData: Diary?
    @State private var error: Error?
    
    var body: some View {
        VStack {
            TextField("날짜 입력 (예: 2023-08-20)", text: $selectedDate)
                .padding()
            
            Button(action: {
                // 사용자가 입력한 날짜로 일기 데이터를 가져오기 위한 함수 호출
                getDiaryData(forDate: selectedDate) { diary, error in
                    if let diary = diary {
                        // 일기 데이터가 성공적으로 받아와졌을 때
                        self.diaryData = diary
                        self.error = nil
                    } else if let error = error {
                        // 오류 처리
                        self.diaryData = nil
                        self.error = error
                    }
                }
            }) {
                Text("일기 데이터 가져오기")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            
            if let diaryData = self.diaryData {
                // 일기 데이터가 있는 경우 표시
                Text("제목: \(diaryData.title)")
                Text("내용: \(diaryData.content)")
            } else if let error = self.error {
                // 오류 메시지 표시
                Text("오류: \(error.localizedDescription)")
                    .foregroundColor(.red)
            }
        }
        .padding()
        .navigationBarTitle("TestView")
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
