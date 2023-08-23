//
//  BasketView.swift
//  one-grain-daily
//
//  Created by 김주현 on 2023/08/20.
//

import SwiftUI
import Alamofire

struct BasketView: View {
    var body: some View {
        var rice:Int = 8000
        
        VStack{
            Text("함께 모은 쌀")
                .font(.title)
                .fontWeight(.heavy)
            
            Spacer().frame(height: 50)

            Text("🍚")
                .font(.system(size: 190))
                .frame(height: 190)
            
            Spacer().frame(height: 50)
            
            Text("\(rice) / 10000")
        }
        
    }
}

struct BasketView_Previews: PreviewProvider {
    static var previews: some View {
        BasketView()
    }
}
