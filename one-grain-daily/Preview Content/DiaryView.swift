import SwiftUI
import Alamofire

struct DiaryView: View {
    // 상태 변수 선언
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    //사용자 정보를 담은 전역변수
    @EnvironmentObject var userModel: UserModel
    
    @State private var title: String = ""
    @State private var emotional: String = "😊"
    @State private var content: String = ""
    
    @State private var showAlert = false
    @State private var alertMessage: String = ""
    
    // 이모티콘 목록
    let emotions = ["😄", "😢", "😡", "😷","🥱", "😴"]
    let emotions2 = ["happy", "sad", "angry", "sick", "tired", "sleepy"]
    //happy, sad, angry, sick, tired, sleepy
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("제목")) {
                    TextField("제목을 입력하세요", text: $title)
                }
                
                Section(header: Text("오늘의 감정")) {
                    Picker("감정 선택", selection: $emotional) {
                        ForEach(emotions, id: \.self) { emotion in
                            Text(emotion)
                                .font(Font.system(size: 40))
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("일기 내용")) {
                    TextEditor(text: $content)
                        .frame(height: 200)
                }
                
            }
            .navigationBarTitle("일기 작성")
            .navigationBarItems(
                leading: Button(action: {
                    // 취소 버튼 눌렀을 때 수행할 작업 = 뒤로가기
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("취소")
                },
                trailing: Button(action: {
                    postDiary(content: "\(content)", emotional: "So sad", title: "\(title)") { data, response, error in
                        if let error = error {
                            print("Error: \(error)")
                        } else if let data = data, let response = response as? HTTPURLResponse {
                            if 200 ..< 300 ~= response.statusCode {
                                // 성공적으로 요청이 처리됨
                                print("일기가 성공적으로 게시되었습니다.")
                                showAlert = true //일기가 저장되었다는 알림을 띄워주기 위한 변수
                            } else {
                                // 요청이 실패했을 때
                                print("HTTP Status Code: \(response.statusCode)")
                            }
                        }
                    }

                }) {
                    Text("저장")
                }
            ).alert(isPresented: $showAlert) {
                
                Alert(title: Text("알림"), message: Text("일기 작성 완료!"), dismissButton: .default(Text("확인")) {
                    // 저장이 완료되면 경고창을 닫고 뒤로 가기
                    presentationMode.wrappedValue.dismiss()
                })
                
            }
            
        }
    }
    
    
    private func makeParameter(content : String, emotional : String, title : String) -> Parameters
        {
            return ["content" : content,
                    "emotional" : emotional,
                    "title" :title
            ]
        }
    
    func postDiary(content: String, emotional: String, title: String, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let urlString = "http://115.85.183.243:8080/api/v1/user/diaryPosting"
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        // POST 요청 설정
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // 요청 바디 데이터 설정
        let postData = """
            {
                "content": "\(content)",
                "emotional": "\(emotional)",
                "title": "\(title)"
            }
        """.data(using: .utf8)
        
        request.httpBody = postData
        
        // HTTP 요청 헤더 설정
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        //userModel.token
        request.addValue("Bearer \(userModel.token)", forHTTPHeaderField: "Authorization")
            
        
        // URLSession을 사용하여 요청 보내기
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            completion(data, response, error)
        }
        
        task.resume()
    }

    
    func diaryPost() {
        
        showAlert = true //일기가 저장되었다는 알림을 띄워주기 위한 변수
        
        // Validation checks
//        guard !title.isEmpty else {
//            showAlert(message: "제목을 작성해주세요.")
//            return
//        }
//
//        guard !emotional.isEmpty else {
//            showAlert(message: "감정을 선택해 주세요.")
//            return
//        }
//
//        guard !content.isEmpty else {
//            showAlert(message: "일기내용을 작성해주세요.")
//            return
//        }
//
//        let diaryPost = DiaryPost(
//            content : content,
//            emotional : emotional,
//            title :title
//        )

        
        let parameters: [String: Any] = [
                    "title": title,
                    "content": content,
                    "emotional": emotional,
                    
                ]

        let url = "http://115.85.183.243:8080/api/v1​/user​/diaryPosting"
        
        
        let header: HTTPHeaders = ["Content-Type": "application/json",
                                   "Authorization": String(userModel.token)]
        
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: header)
                    .responseJSON { response in
                        switch response.result {
                        case .success(let data):
                            if let jsonData = try? JSONSerialization.data(withJSONObject: data),
                               let jsonString = String(data: jsonData, encoding: .utf8) {
                                print("Response: \(jsonString)")
                            }

                        case .failure(let error):
                            print("------------------------")
                            print("Error: \(error)")
                            print(url)
                            print(header)
                            print(JSONEncoding.default)
                        }
                    }
    }
    
    func showAlert(message: String) {
        alertMessage = message
        showAlert = true
    }
    
}
    
    

struct DiaryView_Previews: PreviewProvider {
    static var previews: some View {
        DiaryView()
    }
}
