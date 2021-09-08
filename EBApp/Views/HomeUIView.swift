//
//  HomeUIView.swift
//  EBApp
//
//  Created by Md. Afzal Hossain on 8/28/21.
//

import SwiftUI

struct HomeUIView: View {
    
    
    @State var isLoad: Bool = false
    @Binding var isLogin: Bool
    @Binding var index: Int
    @Binding var title: String
    @Binding var lastPageIdx: Int
    @Binding var lastPageArray: [Int]
    
    @State var lastLatitude : Double
    @State var lastLongitude : Double
    
    @State var height: CGFloat = UIScreen.main.bounds.height/5
    @State var selectedIndex = 0
    @State private var kpiIndex = 0
    @State var width = UIScreen.main.bounds.width - 120
    @State var qaValue: CGFloat = (UIScreen.main.bounds.height > 700 ? 50: 40)
    
    @State var streetLocation:String=""
    @State var searchAddress:String=""
    @State var isFocused:Bool=true
    @State var requestSearch:Bool=true
    @State var myMenu: String = "500002"
    
    
    @State var userName: String = ""
    @State var loginTime: String = ""
    @State var business: String = ""
    @State var role: String = ""
    @State var fullRole: String = ""

    @State var isToast: Bool = false
    @State var ToastMsg: String = ""
    @State var notifyX: CGFloat = -1000
    
    @State var NotificatioList = [NotificationInfo]()
    
    var body: some View {
        ZStack{
            ToastView(isShowing: $isToast, message:$ToastMsg) {
                ZStack{
                    VStack{
                        VStack(spacing: 10){
                            VStack{
                                HStack{
                                    HStack{
                                        Text(self.userName).foregroundColor(Color("IconColor")).font(.system(size: 14)).fontWeight(.semibold)
                                    }
                                    .frame(width: self.width/2, height: 30, alignment: .leading)
                                    Spacer(minLength: 5)
                                    HStack{
                                        
                                        Text("Login:").foregroundColor(Color("IconColor")).font(.system(size: 14)).fontWeight(.semibold)
                                        Text(self.loginTime).foregroundColor(Color("IconColor")).font(.system(size: 14)).fontWeight(.thin).padding(.leading,1)
                                        Spacer()
                                    }
                                    .frame(width: self.width/1.5, height: 30, alignment: .trailing)
                                }
                                HStack{
                                    Text(self.business).foregroundColor(Color("IconColor")).font(.system(size: 12)).fontWeight(.semibold)
                                    Spacer()
                                    HStack{
                                        Button(action: {
                                            funNotificationList()
                                            withAnimation {
                                                self.notifyX = 0
                                            }
                                        }) {
                                            ZStack{
                                                Image(systemName: "bell").foregroundColor(Color("btnColor"))
                                                if(NotificationCount>0){
                                                Image(systemName: "\(NotificationCount).circle.fill")
                                                    .resizable()
                                                    .foregroundColor(Color("btnColor"))
                                                    .frame(width: 8, height: 8)
                                                    .offset(x: -5, y: 5)
                                                }
                                            }
                                        }
                                    }.padding(.trailing, 15)
                                }
                                HStack{
                                    Text(self.fullRole).foregroundColor(Color("IconColor")).font(.system(size: 12)).fontWeight(.semibold)
                                    Spacer()
                                }
                            }
                            
                            .onAppear(perform: {
                                
                                let defaults = UserDefaults.standard
                                if let name: String = defaults.string(forKey: defaultsKeys.User_Name){
                                    self.userName = name
                                    self.business = defaults.string(forKey: defaultsKeys.Business_Name)!
                                    self.loginTime = defaults.string(forKey: defaultsKeys.Last_Login_Time)!
                                    self.role = defaults.string(forKey: defaultsKeys.Role_Name)!
                                    self.fullRole = defaults.string(forKey: defaultsKeys.Role_Name_Full)!
                                }
                                else{
                                    self.isLogin.toggle()
                                }
                                
                                if LastCheckIn.count==0{
                                    funLastCheckIn()
                                }
                                    
                            })
                            .padding(.top,10)
                            .padding(.leading, 10)
                            .padding(.trailing, 10)
                            
                            Divider()
                            
                            ZStack{
                            VStack(spacing: 10){
                                HStack{
                                    Text("Quick Access").foregroundColor(Color("IconColor")).fontWeight(.semibold).padding(.leading,10)
                                    Spacer()
                                }
                                
                                HStack{
                                    Button(action: {
                                        if LastCheckIn.count>0{
                                            self.ToastMsg="You already checked-in! If you want to check-in then check-out first!!"
                                            self.isToast.toggle()
                                            
                                            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
                                                self.isToast.toggle()
                                            })
                                        }
                                        else{
                                            if self.myMenu.contains("500002") {
                                                self.index = 1
                                                self.title = "Check-In"
                                                self.lastPageArray.append(0)
                                            }
                                        }
                                    }, label: {
                                        
                                        VStack(spacing: 5){
                                            Image("check_in")
                                                .resizable()
                                                .frame(width: qaValue, height: qaValue)
                                            Text("Check-In").foregroundColor(Color("IconColor")).font(.system(size: 12))
                                        }
                                    })
                                    Spacer(minLength: 0)
                                    Button(action: {
                                        
                                        if self.myMenu.contains("500002") {
                                            self.index = 3
                                            self.title = "Visit Report"
                                            self.lastPageArray.append(0)
                                        }
                                    }, label: {
                                        VStack(spacing: 5){
                                            Image("history")
                                                .resizable()
                                                .frame(width: qaValue, height: qaValue)
                                            Text("Visit Report").foregroundColor(Color("IconColor")).font(.system(size: 12))
                                        }
                                    })
                                    Spacer(minLength: 0)
                                    Button(action: {
                                        if LastCheckIn.count==0{
                                            self.ToastMsg="You have no previous checked-in records!!"
                                            self.isToast.toggle()
                                            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
                                                self.isToast.toggle()
                                            })
                                        }
                                        else{
                                            if self.myMenu.contains("500002") {
                                                self.title = "Check-Out"
                                                self.index = 2
                                                self.lastPageArray.append(0)
                                            }
                                        }
                                    }, label: {
                                        VStack(spacing: 5){
                                            Image("check_out")
                                                .resizable()
                                                .frame(width: qaValue, height: qaValue)
                                            Text("Check-Out").foregroundColor(Color("IconColor")).font(.system(size: 12))
                                        }
                                    })
                                }
                                .padding(.leading, 20)
                                .padding(.trailing, 20)
                                
                                
                                HStack{
                                    Button(action: {
                                        
                                        if self.myMenu.contains("500002") {
                                            self.index = 4
                                            self.title = "Sales Update"
                                            self.lastPageArray.append(4)
                                        }
                                    }, label: {
                                        
                                        VStack(spacing: 5){
                                            Image("Q4")
                                                .resizable()
                                                .frame(width: qaValue, height: qaValue)
                                            Text("Sales Update").foregroundColor(Color("IconColor")).font(.system(size: 12))
                                        }
                                    })
                                    Spacer(minLength: 0)
                                    Button(action: {
                                        
                                        if self.myMenu.contains("500002") {
                                            self.index = 5
                                            self.title = "KIP Dashboard"
                                            self.lastPageArray.append(5)
                                        }
                                    }, label: {
                                        VStack(spacing: 5){
                                            Image("Q1")
                                                .resizable()
                                                .frame(width: qaValue, height: qaValue)
                                            Text("KIP Dashboard").foregroundColor(Color("IconColor")).font(.system(size: 12))
                                        }
                                    })
                                    Spacer(minLength: 0)
                                    Button(action: {
                                        if self.myMenu.contains("500002") {
                                            self.title = "Gift Inventory Stock"
                                            self.index = 6
                                            self.lastPageArray.append(6)
                                        }
                                    }, label: {
                                        VStack(spacing: 5){
                                            Image("Q6")
                                                .resizable()
                                                .frame(width: qaValue, height: qaValue)
                                            Text("Gift Inv. Stock").foregroundColor(Color("IconColor")).font(.system(size: 12))
                                        }
                                    })
                                }
                                .padding(.leading, 20)
                                .padding(.trailing, 20)
                            }
                            .foregroundColor(Color("IconColor"))
                        }
                        .background(Color("BarColor"))
                        .padding(.top, 0).cornerRadius(3.0)
                        .offset(y:10)
                        }
                        Divider()
                        VStack{
//                            ZStack{
                                GoogleMapsView(isFocused: $isFocused, lastLatitude: self.lastLatitude, lastLongitude: self.lastLongitude)
                                .onAppear(perform: {
                                    print(lastLatitude)
                                    print(lastLongitude)
                                })
//                            }
                        }
                    }
                }
            }
            
            if notifyX >= 0 {
                NotificationPopUp(x: $notifyX, NotificatioList: $NotificatioList)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height-50, alignment: .center)
                .shadow(color: Color.black.opacity(notifyX != 0 ? 0.1 : 0), radius: 5, x: 5, y: 0)
                .offset(x: notifyX, y: 0)
                .background(Color.black.opacity(notifyX == 0 ? 0.5 : 0)
                .onTapGesture {
                    self.notifyX = -800
                })
            }
            
            
        }
    }
    
    func funNotificationList() {
        guard let url = URL(string: baseUrl+"/api/EB_AMS_User/Get_Notification") else { return }
        
        let defaults = UserDefaults.standard
        
        let Login_Name = defaults.string(forKey: defaultsKeys.Login_Name)!
        let Access_Key = defaults.string(forKey: defaultsKeys.Access_Key)!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let postString = "{'USER_NAME':'\(Login_Name)','ACCESS_KEY':'\(Access_Key)'}";
        // Set HTTP Request Body
        request.httpBody = postString.data(using: String.Encoding.utf8);
        
        self.NotificatioList.removeAll()
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                return
            }
            if let dataString = String(data: data, encoding: .utf8) {
                print("Response data string:\n \(dataString)")
                let decoder = JSONDecoder()

                do {
                    let resData = try decoder.decode([NotificationInfoX].self, from: data)
                    print(resData)
                    for i in 0...resData.count-1 {
                        let obj=resData[i]
                        self.NotificatioList.append(NotificationInfo.init(SL: i, COMPANY_NAME: obj.COMPANY_NAME, OCCASION_DETAIL: obj.OCCASION_DETAIL, OCCASION_DATE: obj.OCCASION_DATE))
                    }
                    
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        .resume()
    }
    
    func funLastCheckIn() {
        guard let url = URL(string: baseUrl+"/api/EB_AMS_User/Get_Last_Check_In_Info") else { return }
        
        let defaults = UserDefaults.standard
        
        let Login_Name = defaults.string(forKey: defaultsKeys.Login_Name)!
        let Access_Key = defaults.string(forKey: defaultsKeys.Access_Key)!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let postString = "{'USER_NAME':'\(Login_Name)','ACCESS_KEY':'\(Access_Key)'}";
        // Set HTTP Request Body
        request.httpBody = postString.data(using: String.Encoding.utf8);
        
        LastCheckIn.removeAll()
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                return
            }
            if let dataString = String(data: data, encoding: .utf8) {
                print("Response data string:\n \(dataString)")
                let decoder = JSONDecoder()

                do {
                    let resData = try decoder.decode(CheckinInfo.self, from: data)
                    print(resData)
                    if(resData.CHECK_OUT_STATUS==0){
                        LastCheckIn.append(resData)
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        .resume()
    }
    
}
