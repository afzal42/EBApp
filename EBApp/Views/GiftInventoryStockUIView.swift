//
//  HistoryUIView.swift
//  EBApp
//
//  Created by Md. Afzal Hossain on 8/28/21.
//


import SwiftUI

struct GiftInventoryStockUIView: View {
    @Binding var index: Int
    @Binding var lastPageIdx: Int
    @Binding var lastPageArray: [Int]
    @Binding var title: String
    
    @State private var dtToDate = Date()
    @State var toDate:String = ""
    
    @State var isLoad: Bool = false
    
    @State var tableHeader = ["Department Name","Product Code","Product Name","Product Type","Product Qty"]
    @State var UserGiftList = [UserGiftInfo]()
    
    func funVisitHistory() {
        guard let url = URL(string: baseUrl+"/api/EB_AMS_User/Get_User_Gift_Status") else { return }
        
        let defaults = UserDefaults.standard
        
        let Login_Name = defaults.string(forKey: defaultsKeys.Login_Name)!
        let Access_Key = defaults.string(forKey: defaultsKeys.Access_Key)!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let postString = "{'USER_NAME':'\(Login_Name)','ACCESS_KEY':'\(Access_Key)'}";
        // Set HTTP Request Body
        request.httpBody = postString.data(using: String.Encoding.utf8);
        
        self.UserGiftList.removeAll()
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                return
            }
            if let dataString = String(data: data, encoding: .utf8) {
//                print("Response data string:\n \(dataString)")
                let decoder = JSONDecoder()

                do {
                    let resData = try decoder.decode([UserGiftInfoX].self, from: data)
                    if dataString != "[]"{
//                    print(resData)
                    for i in 0...resData.count-1 {
                        let obj = resData[i]
                        self.UserGiftList.append(UserGiftInfo.init(SL: i+1, DEPARTMENT_NAME: obj.DEPARTMENT_NAME, PRODUCT_CODE: obj.PRODUCT_CODE, PRODUCT_NAME: obj.PRODUCT_NAME, PRODUCT_TYPE: obj.PRODUCT_TYPE, PRODUCT_COUNT: obj.PRODUCT_COUNT))
                    }
                    }
                } catch {
                    print(error.localizedDescription)
                }
                
            }
        }
        .resume()
    }
    
    
    var body: some View {
        ZStack{
            LoadingView(isShowing: $isLoad) {
                ZStack{
                    VStack(spacing:0){
                        
                        HStack{
                            
                            Spacer(minLength: 1)
                            ForEach(self.tableHeader, id:\.self){i in
                                HStack{
                                    Text(i)
                                        .fontWeight(.bold)
                                        .font(.system(size: 10)).multilineTextAlignment(.center)
                                }.frame(width: UIScreen.main.bounds.width/5.5)
                                
                                Spacer(minLength: 1)
                            }
                        }
                        .padding(5)
                        .padding(.top, 20)
                        .padding(.bottom, 10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 0)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                        VStack{
                            
                            ScrollView(.vertical, showsIndicators: false) {
                                
                                ForEach(UserGiftList, id:\.SL){i in
                                    HStack{
                                        HStack{
                                            Text(i.DEPARTMENT_NAME)
                                                .fontWeight(.bold)
                                                .font(.system(size: 10)).multilineTextAlignment(.leading)
                                            Spacer(minLength: 0)
                                        }.frame(width: UIScreen.main.bounds.width/5.2)
                                        .padding(.leading, 5)
//
                                        HStack{
                                            Text(i.PRODUCT_CODE)
                                                .fontWeight(.bold)
                                                .font(.system(size: 10)).multilineTextAlignment(.center)
                                        }.frame(width: UIScreen.main.bounds.width/5.5)
//
                                        HStack{
                                            Text(i.PRODUCT_NAME)
                                                .fontWeight(.bold)
                                                .font(.system(size: 10)).multilineTextAlignment(.center)
                                        }.frame(width: UIScreen.main.bounds.width/5.5)
//
                                        HStack{
                                            Text(i.PRODUCT_TYPE)
                                                .fontWeight(.bold)
                                                .font(.system(size: 10)).multilineTextAlignment(.center)
                                        }.frame(width: UIScreen.main.bounds.width/5.5)

                                        HStack{
                                            Text(String(i.PRODUCT_COUNT))
                                                .fontWeight(.bold)
                                                .font(.system(size: 10)).multilineTextAlignment(.center)
                                        }.frame(width: UIScreen.main.bounds.width/5.5)
                                        Spacer()
                                    }
                                    .padding(.top,5)
                                    .padding(.bottom,5)
                                    .background(Color("IconColor").opacity(i.SL % 2 == 0 ? 0.1 : 0))
                                }
                            }
                        }
                        .padding(1)
                        
                        Spacer()
                    }
                    .onAppear(perform: {
                        self.funVisitHistory()
                    })
                }
            }
             
        }
        
    }
}

//Afzal
