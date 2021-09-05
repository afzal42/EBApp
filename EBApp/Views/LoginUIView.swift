//
//  LoginUIView.swift
//  EBApp
//
//  Created by Md. Afzal Hossain on 8/30/21.
//

import Foundation
import SwiftUI
import Combine
import MessageUI
//import Firebase



struct LoginUIView: View {
    @State private var txtMobile: String = "cam_user"//"cam_user"
    @State private var txtCode: String = "12345"//"12345"
    @Binding var isLogin: Bool
    @State var showMsg: Bool = false
    @State private var msg: String = "Invalid Mobile No."
    
    @State var text = ""
    @State var idx: Int = 0
    
    @State var isLoad: Bool = false
    @State var appVersion: String = ""
    @State var appName: String = ""
    @State var ReleaseDate: String = ""
//    func handleLogTokenTouch() {
//        let token = Messaging.messaging().fcmToken
//        print("FCM token: \(token ?? "")")
//        ReceiverFCMToken = token ?? "ased"
//
//
//        InstanceID.instanceID().instanceID { (result, error) in
//            if let error = error {
//                print("Error fetching remote instance ID: \(error)")
//            } else if let result = result {
//                print("Remote instance ID token: \(result.token)")
//            }
//        }
//        // [END log_iid_reg_token]
//    }
    
    var body: some View {
        LoadingView(isShowing: $isLoad){
            VStack(spacing: 10){
                
                VStack{
                    ZStack{
                        VStack{
                            HStack{
                                Text("Version Name:"+self.appName+" "+self.appVersion).foregroundColor(Color("IconColor")).font(.system(size: 10)).fontWeight(.thin)
                                Spacer()
                            }
                            .padding(.leading, 10)
                            
                            HStack{
                                Text("Release Date:"+self.ReleaseDate).foregroundColor(Color("IconColor")).font(.system(size: 10)).fontWeight(.thin)
                                Spacer()
                            }
                            .padding(.leading, 10)
                            
                            Text("Login").font(.title)
                            HStack{
                                Image("logo").resizable() .padding(12)
                                    .frame(width: 110, height: 135, alignment: .center)
                            }
                            .padding(1)
                            .cornerRadius(5)
                        }
                    }
                }
                .onAppear(perform: {
//                    handleLogTokenTouch()
//                    let defaults = UserDefaults.standard
                    
                    let info = Bundle.main.infoDictionary
                    print(info as Any)
                    if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
                        self.appVersion = version
                    }
                    if let name = Bundle.main.infoDictionary?["CFBundleName"] as? String {
                        self.appName = name
                    }
                 })
                .padding(.top, 30)
                
                VStack{
                    
                    HStack(spacing: 0){
                        
                        TextField("User Name", text: self.$txtMobile
                        ).textFieldStyle(RoundedBorderTextFieldStyle())
//                        .keyboardType(.numberPad)
                        .font(.system(size: 20))
                        .onReceive(Just(self.txtMobile)) { inputValue in
                               
                            if inputValue.count > 11 {
                                self.txtMobile.removeLast()
                            }
                        }
                    }
                    
                }
                .padding(.top, 10)
                .padding(.leading, 10)
                .padding(.trailing, 10)
                
                VStack{
                    HStack(spacing: 0){
                        
                        TextField("Password", text: self.$txtCode
                        ).textFieldStyle(RoundedBorderTextFieldStyle())
//                        .keyboardType(.numberPad)
                        .font(.system(size: 20))
                    }
                    if showMsg {
                        HStack{
                            Text(msg).foregroundColor(Color("btnColor"))
                            Spacer()
                        }
                    }
                }
                .padding(.top, 0)
                .padding(.leading, 10)
                .padding(.trailing, 10)
                
                VStack{
                    
                    HStack(spacing: 0){

                        Button(action: {
                            if (self.txtMobile == "" || self.txtCode == ""){
                                showMsg = true
                                msg  = "Invalid Mobile/Password"
                            }
                            else{
                                self.isLoad.toggle()
                                checkUserAuth(User_Id: self.txtMobile, Password: self.txtCode)
                            }

                        }) {
                            Text("LOGIN")
                                .foregroundColor(Color.white)
                                .fontWeight(.bold)
                                .frame(width: (UIScreen.main.bounds.width - 20), height: 40)
                                .background(Color("btnColor"))
                                .cornerRadius(6)
                        }
                    }
                    
                }
                .padding(0)
                Spacer()
            }
            .edgesIgnoringSafeArea(.all)
        }
    }

    func checkUserAuth(User_Id: String, Password: String) {
        guard let url = URL(string: baseUrl+"/api/EB_AMS_User/Login/") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let postString = "{'USER_NAME':'\(User_Id)','USER_PASSWORD':'\(Password)'}";
        // Set HTTP Request Body
        request.httpBody = postString.data(using: String.Encoding.utf8);
        
        UserResults.removeAll()
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {

                msg = "Invalid mobile no.!"
                showMsg = true
                self.isLoad.toggle()
                return

            }
            if let dataString = String(data: data, encoding: .utf8) {
                print("Response data string:\n \(dataString)")
                let decoder = JSONDecoder()

                do {
                    let resData = try decoder.decode(UserData.self, from: data)
                    print(resData)
                    if resData.success == true {
                        
                        UserResults.append(resData)
                        
                        let defaults = UserDefaults.standard
                        
                        defaults.set(UserResults[0].User_Id, forKey: defaultsKeys.User_Id)
                        defaults.set(UserResults[0].Login_Name, forKey: defaultsKeys.Login_Name)
                        defaults.set(UserResults[0].User_Name, forKey: defaultsKeys.User_Name)
                        defaults.set(UserResults[0].User_Status, forKey: defaultsKeys.User_Status)
                        defaults.set(UserResults[0].Is_Locked, forKey: defaultsKeys.Is_Locked)
                        defaults.set(UserResults[0].Is_Internal, forKey: defaultsKeys.Is_Internal)
                        defaults.set(UserResults[0].Role_Name, forKey: defaultsKeys.Role_Name)
                        
                        defaults.set(UserResults[0].Role_Name_Full, forKey: defaultsKeys.Role_Name_Full)
                        defaults.set("12345", forKey: defaultsKeys.Access_Key)
//                        defaults.set(UserResults[0].Access_Key, forKey: defaultsKeys.Access_Key)
                        defaults.set(UserResults[0].Business_Name, forKey: defaultsKeys.Business_Name)
                        defaults.set(UserResults[0].Last_Login_Time, forKey: defaultsKeys.Last_Login_Time)
                        defaults.set(UserResults[0].Login_Status, forKey: defaultsKeys.Login_Status)
                        
                        self.isLogin.toggle()
                        self.isLoad.toggle()
                    }
                    else{
                        msg = "Invalid mobile no.!"
                        showMsg = true
                        self.isLoad.toggle()
                    }
                } catch {
                    print(error.localizedDescription)
                    msg = "Invalid mobile no.!"
                    self.isLoad.toggle()
                }
                
            }
        }
        .resume()
    }
}
