//
//  CompanyTypePopUp.swift
//  EBApp
//
//  Created by Md. Afzal Hossain on 9/1/21.
//


import SwiftUI

struct CompanyTypePopUp: View {
    
    var funCompanyInfo: () -> Void
    @Binding var x : CGFloat
    @Binding var CompanyTypeVal : Int
    @Binding var CompanyTypeName : String
    @Binding var CompanyTypeList: [CompanyTypeInfo]
    
    var body: some View {
        VStack{
            VStack(spacing:5){
                ScrollView(.vertical, showsIndicators: true, content: {
                    
                    ForEach(self.CompanyTypeList, id: \.COMPANY_TYPE_ID){i in
                        
                        Button(action: {
                            self.CompanyTypeVal=i.COMPANY_TYPE_ID
                            self.CompanyTypeName=i.COMPANY_TYPE_NAME
                            self.x = -800
                            self.funCompanyInfo()
                        }, label: {
                            HStack{
                                Text(i.COMPANY_TYPE_NAME)
                                Spacer()
                            }.padding(10)
                            .foregroundColor(.primary)
                        })
                    }
                    
                })
            }
            .padding(20)
            .onAppear(perform: {
                self.hideKeyboard()
            })
            
        }
        .frame(width: UIScreen.main.bounds.width/2, height: (UIScreen.main.bounds.height/3.5))
        .background(Color("BarColor"))
        .cornerRadius(5)
        .offset(y: -40)
    }
}
