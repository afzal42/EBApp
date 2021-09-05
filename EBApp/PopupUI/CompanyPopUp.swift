//
//  CompanyPopUp.swift
//  EBApp
//
//  Created by Md. Afzal Hossain on 9/1/21.
//

import SwiftUI

struct CompanyPopUp: View {
    
    @Binding var x : CGFloat
    @Binding var CompanyVal : Int
    @Binding var CompanyName : String
    @Binding var CompanyAddress : String
    @Binding var CurrentDataList: [CompanyInfo]
    @State var txtSearch: String = ""
    
    @ObservedObject private var keyboard = KeyboardResponder()
    
    var body: some View {
        VStack{
            
            VStack(spacing:5){
                
                TextField("Search Company...!",text: $txtSearch)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                    .autocapitalization(UITextAutocapitalizationType.allCharacters)
                    .disableAutocorrection(true)
                    .padding(5)
                if self.CurrentDataList.count>0{
                    ScrollView(.vertical, showsIndicators: true, content: {
                        if txtSearch.count>2 && self.CurrentDataList.count>0 {
                            ForEach(self.CurrentDataList.filter({$0.COMPANY_NAME.lowercased().contains(self.txtSearch.lowercased())}),id: \.ID){i in
                                
                                Button(action: {
                                    self.CompanyVal=i.ID
                                    self.CompanyName=i.COMPANY_NAME
                                    self.CompanyAddress=i.COMPANY_ADDRESS
                                    self.hideKeyboard()
                                    self.x = -800
                                    
                                }, label: {
                                    HStack{
                                        Text(i.COMPANY_NAME).font(.system(size: 14))
                                        Spacer()
                                    }.padding(5)
                                    .foregroundColor(Color.primary)
                                })
                            }
                        }
                        else{
                            if #available(iOS 14.0, *) {
                                if self.txtSearch.count>2 {
                                    LazyVStack {
                                        ForEach(self.CurrentDataList.filter({$0.COMPANY_NAME.lowercased().contains(self.txtSearch.lowercased())}), id: \.ID){i in
                                            Button(action: {
                                                self.CompanyVal=i.ID
                                                self.CompanyName=i.COMPANY_NAME
                                                self.CompanyAddress=i.COMPANY_ADDRESS
                                                self.hideKeyboard()
                                                self.x = -800
                                            }, label: {
                                                HStack{
                                                    Text(i.COMPANY_NAME).font(.system(size: 14))
                                                    Spacer()
                                                }.padding(5)
                                                .foregroundColor(Color.primary)
                                            })
                                        }
                                    }
                                }
                                else{
                                    LazyVStack {
                                        ForEach(self.CurrentDataList, id: \.ID){i in
                                            Button(action: {
                                                self.CompanyVal=i.ID
                                                self.CompanyName=i.COMPANY_NAME
                                                self.CompanyAddress=i.COMPANY_ADDRESS
                                                self.hideKeyboard()
                                                self.x = -800
                                                
                                            }, label: {
                                                HStack{
                                                    Text(i.COMPANY_NAME).font(.system(size: 14))
                                                    Spacer()
                                                }.padding(5)
                                                .foregroundColor(Color.primary)
                                            })
                                        }
                                    }
                                }
                            } else {
                                
                                if self.txtSearch.count>2 {
                                    ForEach(self.CurrentDataList.filter({$0.COMPANY_NAME.lowercased().contains(self.txtSearch.lowercased())}),id: \.ID){i in
                                        Button(action: {
                                            self.CompanyVal=i.ID
                                            self.CompanyName=i.COMPANY_NAME
                                            self.CompanyAddress=i.COMPANY_ADDRESS
                                            self.hideKeyboard()
                                            self.x = -800
                                        }, label: {
                                            HStack{
                                                Text(i.COMPANY_NAME).font(.system(size: 14))
                                                Spacer()
                                            }.padding(5)
                                            .foregroundColor(Color.primary)
                                        })
                                    }
                                }
                                else{
                                    ForEach(self.CurrentDataList,id: \.ID){i in
                                        Button(action: {
                                            self.CompanyVal=i.ID
                                            self.CompanyName=i.COMPANY_NAME
                                            self.CompanyAddress=i.COMPANY_ADDRESS
                                            self.hideKeyboard()
                                            self.x = -800
                                        }, label: {
                                            HStack{
                                                Text(i.COMPANY_NAME).font(.system(size: 14))
                                                Spacer()
                                            }.padding(5)
                                            .foregroundColor(Color.primary)
                                        })
                                    }
                                }
                            }
                        }
                    })
                }
                else{
                    Text("Please Wait, Data Loading in Progress....!").foregroundColor(Color.red).font(.system(size: 14))
                    Spacer()
                }
            }
            .padding(20)
            .onAppear(perform: {
                self.hideKeyboard()
            })
            
        }
        .frame(width: UIScreen.main.bounds.width/1.5, height: (UIScreen.main.bounds.height/2))
        .background(Color("BarColor"))
        .cornerRadius(5)
        .offset(y: -40)
    }
}
//Afzal
