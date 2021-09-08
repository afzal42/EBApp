//
//  NotificationPopUp.swift
//  EBApp
//
//  Created by Md. Afzal Hossain on 9/7/21.
//

import SwiftUI

struct NotificationPopUp: View {
    
    @Binding var x : CGFloat
    @Binding var NotificatioList: [NotificationInfo]
    
    var body: some View {
        VStack{
            VStack(spacing:5){
                ScrollView(.vertical, showsIndicators: true, content: {
                    
                    ForEach(self.NotificatioList, id: \.SL){i in
                        HStack{
                            PopUpButton(title: i.OCCASION_DETAIL)
                        }
                        .background(Color("IconColor").opacity(i.SL % 2 == 0 ? 0.1 : 0))
                    }
                })
                
                HStack{
                    Spacer(minLength: 0)
                    Button(action: {
                        self.x = -1000
                    }, label: {
                        Text("OK")
                        .fontWeight(.bold)
                        .frame(height: 15)
                        .padding(.leading,10).padding(.trailing,10)
                        .padding(5)
                        .foregroundColor(Color.white)
                    })
                    .background(Color("btnColor"))
                    .cornerRadius(3)
                    
                }
                .padding(.top, 20)
            }
            .padding(20)
            .onAppear(perform: {
                self.hideKeyboard()
            })
            
        }
        .frame(width: UIScreen.main.bounds.width/1.2, height: UIScreen.main.bounds.width/1.2)
        .background(Color("BarColor"))
        .cornerRadius(5)
        .offset(y: -40)
    }
}
