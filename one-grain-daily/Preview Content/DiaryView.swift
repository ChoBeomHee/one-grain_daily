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
    let emotions = ["😄", "😢", "😡", "😍", "😴"]
    
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
                    // 일기 저장 또는 다른 작업을 수행할 수 있음
                    diaryPost()
                }) {
                    Text("저장")
                }
            ).alert(isPresented: $showAlert) {
                
                Alert(title: Text("알림"), message: Text(alertMessage), dismissButton: .default(Text("확인")) {
                    // 저장이 완료되면 경고창을 닫고 뒤로 가기
                    presentationMode.wrappedValue.dismiss()
                })
                
            }
            
        }
    }
    
    // 일기를 저장하는 함수
    func saveDiary() {
        showAlert = true //일기가 저장되었다는 알림을 띄워주기 위한 변수
        // 여기에서 일기 저장 로직을 구현할 수 있음
        print("제목: \(title)")
        print("감정: \(emotional)")
        print("내용: \(content)")
        
        // 저장 후 필요한 작업 수행
    }
    
    func diaryPost() {
        
        showAlert = true //일기가 저장되었다는 알림을 띄워주기 위한 변수
        
        // Validation checks
        guard !title.isEmpty else {
            showAlert(message: "제목을 작성해주세요.")
            return
        }
        
        guard !emotional.isEmpty else {
            showAlert(message: "감정을 선택해 주세요.")
            return
        }
        
        guard !content.isEmpty else {
            showAlert(message: "일기내용을 작성해주세요.")
            return
        }
        
        let diaryPost = DiaryPost(
            content : content,
            emotional : emotional,
            title :title
        )
        let encoTitle = makeStringKoreanEncoded(title)
        let encoemotion = makeStringKoreanEncoded(emotional)
        let encoContent = makeStringKoreanEncoded(content)
        

        let url = "http://115.85.183.243:8080​/api​/v1​/user​/diaryPosting?content=\(encoContent)&emotional=\(encoemotion)&title=\(title)"
        
        let headers: HTTPHeaders = ["Content-Type": "application/json"]
        
        AF.request(url, method: .post, headers: headers)
            .responseJSON { response in
                
                switch response.result {
                case .success:
                    showAlert(message: "리뷰 작성이 완료되었습니다.")
                    
                    
                case .failure(let error):
                    showAlert(message: "리뷰 작성 실패 \(error.localizedDescription)")
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
