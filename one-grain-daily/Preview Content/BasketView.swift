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
            Text("바구니")
                .font(.title2)
                .fontWeight(.heavy)
            
            Image("Rice")
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            Text("\(rice) / 10000")
        }
        
    }
}

struct BasketView_Previews: PreviewProvider {
    static var previews: some View {
        BasketView()
    }
}
