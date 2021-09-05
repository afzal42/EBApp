//
//  CheckInUIView.swift
//  EBApp
//
//  Created by Md. Afzal Hossain on 8/28/21.
//

import SwiftUI
import GoogleMaps
import Combine

struct CheckInUIView: View {
    
    @Binding var index: Int
    @Binding var title: String
    @Binding var lastPageIdx: Int
    @Binding var lastPageArray: [Int]
    @State var lastLatitude : Double
    @State var lastLongitude : Double
    
    @State var isToast: Bool = false
    @State var msg: String = ""
    
    @State var CompanyTypeVal:Int=1
    @State var CompanyTypeName: String="New"
    @State var CompanyName: String=""
    @State var CompanyVal: Int=0
    @State var CompanyAddress: String=""
    @State var Longitude: String=""
    @State var Latitude: String=""
    @State var UserAddress: String=""
    @State var VisitPurposeName: String=""
    @State var VisitPurposeVal:Int=0
    @State var isLoad: Bool = false
    
    @State var compTypeX: CGFloat = -1000
    @State var compX: CGFloat = -1000
    @State var visitPurX:CGFloat = -1000
    @State var width: CGFloat = 1.5
    
    func getAddress(latitude: Double, longitude: Double){
//        let longitudeTest: Double = -0.13369839638471603
//        let latitudeTest: Double = 51.510086927204725
        let geocoder = GMSGeocoder()
//        let coordinate = CLLocationCoordinate2DMake(Double(latitudeTest), Double(longitudeTest))
        let coordinate = CLLocationCoordinate2DMake(Double(self.lastLatitude), Double(self.lastLongitude))
        
        geocoder.reverseGeocodeCoordinate(coordinate) { response , error in
            if let address = response?.firstResult() {
                self.UserAddress = address.lines![0]
            }
        }
    }
    
    
    @State var CmpanyTypesList: [CompanyTypeInfo] = [
        .init(COMPANY_TYPE_ID:1,COMPANY_TYPE_NAME:"New"),
        .init(COMPANY_TYPE_ID:2,COMPANY_TYPE_NAME:"Potential"),
        .init(COMPANY_TYPE_ID:3,COMPANY_TYPE_NAME:"Exists")
    ]
    
    var body: some View {
        
        ZStack{
            LoadingView(isShowing: $isLoad) {
                ToastView(isShowing: $isToast, message:$msg) {
                ZStack{
                    
                    ScrollView {
                        VStack(alignment:.leading, spacing:10){
                            
                            VStack(alignment:.leading, spacing:10){
                                
                                HStack{
                                    
                                    Text("Company Type")
                                        .font(.system(size:14))
                                        .foregroundColor(Color("IconColor"))
                                    
                                    Spacer()
                                    HStack{
                                        TextField("Company Type", text: $CompanyTypeName)
                                            .foregroundColor(Color("IconColor"))
                                            .font(.system(size: 12))
                                            .disableAutocorrection(true)
                                            .onTapGesture(perform: {
                                                self.hideKeyboard()
                                                self.compTypeX = 0
                                            })
                                            .frame(width: 150)
                                            .padding(.leading,5)
                                        Image(systemName: "chevron.down")
                                            .overlay(
                                                Rectangle().frame(height: 1.0, alignment: .bottom).padding(.top, 30)
                                            )
                                            .onTapGesture(perform: {
                                                self.compTypeX = 0
                                            })
                                        
                                    }
                                    .overlay(
                                        Rectangle().frame(height: 1.0, alignment: .bottom).padding(.top, 30)
                                    )
                                }
                                .padding(.leading, 20)
                                .padding(.trailing, 20)
                                .padding(.top, 20)
                                
                                HStack{
                                    
                                    Text("Company Name")
                                        .font(.system(size:14))
                                        .foregroundColor(Color("IconColor"))
                                    
                                    Spacer()
                                    if self.CompanyTypeVal==1{
                                        HStack{
                                            TextField("", text: $CompanyName)
                                                .foregroundColor(Color("IconColor"))
                                                .font(.system(size: 12))
                                                .disableAutocorrection(true)
                                                .frame(width: 176)
                                                .padding(.leading,5)
                                        }
                                        .overlay(
                                            Rectangle().frame(height: 1.0, alignment: .bottom).padding(.top, 30)
                                        )
                                    }
                                    else{
                                        HStack{
                                            
                                            TextField("Select Company", text: $CompanyName)
                                                .foregroundColor(Color("IconColor"))
                                                .font(.system(size: 12))
                                                .disableAutocorrection(true)
                                                .onTapGesture(perform: {
                                                    self.hideKeyboard()
                                                    self.compX = 0
                                                })
                                                .frame(width: 150)
                                                .padding(.leading,5)
                                            Image(systemName: "chevron.down")
                                                .overlay(
                                                    Rectangle().frame(height: 1.0, alignment: .bottom).padding(.top, 30)
                                                )
                                                .onTapGesture(perform: {
                                                    self.compX = 0
                                                })
                                        }
                                        .overlay(
                                            Rectangle().frame(height: 1.0, alignment: .bottom).padding(.top, 30)
                                        )
                                    }
                                    
                                }
                                .padding(.leading, 20)
                                .padding(.trailing, 20)
                                .padding(.top, 10)

                                HStack{

                                    Text("Company Address")
                                        .font(.system(size:14))
                                        .foregroundColor(Color("IconColor"))

                                    Spacer()
                                    HStack{
                                        
                                        if #available(iOS 14.0, *) {
                                            TextEditor(text: $CompanyAddress)
        //                                        .foregroundColor(Color("IconColor"))
                                                .font(.system(size: 12))
                                                .frame(width: 180, height: 60)
                                                .disableAutocorrection(true)
                                                .cornerRadius(8)
                                                .disabled(self.CompanyTypeVal>1 ?true:false)
                                                .onReceive(Just(self.CompanyAddress)) { inputValue in
                                                       
                                                    if inputValue.count > 150 {
                                                        self.CompanyAddress.removeLast()
                                                    }
                                                }
                                            
                                        } else {
                                            MultilineTextView(text: $CompanyAddress)
        //                                        .foregroundColor(Color("IconColor"))
                                                .font(.system(size: 12))
                                                .frame(width: 180, height: 60)
                                                .disableAutocorrection(true)
                                                .cornerRadius(8)
                                                .disabled(self.CompanyTypeVal>1 ?true:false)
                                                .onReceive(Just(self.CompanyAddress)) { inputValue in
                                                       
                                                    if inputValue.count > 150 {
                                                        self.CompanyAddress.removeLast()
                                                    }
                                                }
                                        }
                                        
        //                                TextField("", text: $CompanyAddress)
        //                                    .font(.system(size: 12))
        //                                    .disableAutocorrection(true)
        //                                    .frame(width: 176)
        //                                    .padding(.leading,5)
                                        
                                    }
                                    .overlay(
                                        Rectangle().frame(height: 1.0, alignment: .bottom).padding(.top, 60)
                                    )
                                }
                                .padding(.leading, 20)
                                .padding(.trailing, 20)
                                .padding(.top, 10)
                                
                                HStack{
                                    Spacer()
                                    Text(String(self.CompanyAddress.count)+"/150")
                                        .font(.system(size:10))
                                        .foregroundColor(Color("IconColor"))
                                }
                                .padding(.leading, 20)
                                .padding(.trailing, 20)
                                .padding(.top, 0)
                            }
                        
                            VStack(alignment:.leading, spacing:10){
                                HStack{

                                    Text("Latitude")
                                        .font(.system(size:14))
                                        .foregroundColor(Color("IconColor"))

                                    Spacer()
                                    HStack{

                                        Text(String(self.lastLatitude))
                                            .foregroundColor(Color("IconColor"))
                                            .font(.system(size: 12))
                                            .frame(width: 176,alignment: .leading)
                                            .padding(.leading,5)
                                        
                                    }
                                    .overlay(
                                        Rectangle().frame(height: 1.0, alignment: .bottom).padding(.top, 30)
                                    )
                                }
                                .padding(.leading, 20)
                                .padding(.trailing, 20)
                                .padding(.top, 10)

                                HStack{

                                    Text("Longitude")
                                        .font(.system(size:14))
                                        .foregroundColor(Color("IconColor"))

                                    Spacer()
                                    HStack{

                                        Text(String(self.lastLongitude))
                                            .foregroundColor(Color("IconColor"))
                                            .font(.system(size: 12))
                                            .frame(width: 176,alignment: .leading)
                                            .padding(.leading,5)
                                            .multilineTextAlignment(.leading)
                                        
                                    }
                                    .overlay(
                                        Rectangle().frame(height: 1.0, alignment: .bottom).padding(.top, 30)
                                    )
                                }
                                .padding(.leading, 20)
                                .padding(.trailing, 20)
                                .padding(.top, 10)


                                HStack{

                                    Text("Address")
                                        .font(.system(size:14))
                                        .foregroundColor(Color("IconColor"))

                                    Spacer()
                                    HStack{
                                        
                                        if #available(iOS 14.0, *) {
                                            TextEditor(text: $UserAddress)
                                                .foregroundColor(Color("IconColor"))
                                                .font(.system(size: 12))
                                                .frame(width: 180, height: 60)
                                                .disableAutocorrection(true)
                                                .cornerRadius(8)
                                                .disabled(true)
                                            
                                        } else {
                                            MultilineTextView(text: $UserAddress)
                                                .foregroundColor(Color("IconColor"))
                                                .font(.system(size: 12))
                                                .frame(width: 180, height: 60)
                                                .disableAutocorrection(true)
                                                .cornerRadius(8)
                                                .disabled(true)
                                        }
                                        
        //                                Text(self.UserAddress)
        //                                    .font(.system(size: 12))
        //                                    .frame(width: 176,alignment: .leading)
        //                                    .padding(.leading,5)
                                    }
                                    .overlay(
                                        Rectangle().frame(height: 1.0, alignment: .bottom).padding(.top, 60)
                                    )
                                }
                                .padding(.leading, 20)
                                .padding(.trailing, 20)
                                .padding(.top, 10)
                                
                                HStack{
                                    Spacer()
                                    Text(String(self.UserAddress.count)+"/150")
                                        .font(.system(size:10))
                                        .foregroundColor(Color("IconColor"))
                                }
                                .padding(.leading, 20)
                                .padding(.trailing, 20)
                                .padding(.top, 0)
                                

                                HStack{

                                    Text("Visit Purpose")
                                        .font(.system(size:14))
                                        .foregroundColor(Color("IconColor"))

                                    Spacer()
                                    HStack{

                                        TextField("Visit Purpose", text: $VisitPurposeName)
                                            .foregroundColor(Color("IconColor"))
                                            .font(.system(size: 12))
                                            .disableAutocorrection(true)
                                            .onTapGesture(perform: {
                                                self.hideKeyboard()
                                                visitPurX = 0
                                            })
                                            .frame(width: 150)
                                            .padding(.leading,5)
                                        Image(systemName: "chevron.down")
                                            .foregroundColor(Color("IconColor"))
                                            .overlay(
                                                Rectangle().frame(height: 1.0, alignment: .bottom).padding(.top, 30)
                                            )
                                            .onTapGesture(perform: {
                                                visitPurX = 0
                                            })
                                    }
                                    .overlay(
                                        Rectangle().frame(height: 1.0, alignment: .bottom).padding(.top, 30)
                                    )
                                }
                                .padding(.leading, 20)
                                .padding(.trailing, 20)
                                .padding(.top, 10)

                                
                                HStack{
                                    Spacer(minLength: 0)
                                    Button(action: {
                                        self.funSaveCheckIn()
                                        self.funLastCheckIn()
                                    }, label: {
                                        Text("Check-In")
                                        .fontWeight(.bold)
                                        .frame(height: 25)
                                        .padding(.leading,10).padding(.trailing,10)
                                        .padding(5)
                                        .foregroundColor(Color.white)
                                    })
                                    .background(Color("btnColor"))
                                    .cornerRadius(3)
                                    .disabled(LastCheckIn.count==0 ? false:true)
                                    
                                    Spacer(minLength: 0)
                                }
                                .padding(.top, 20)
                                Spacer()
                            }
                        }
                    }
                }
                .onAppear(perform: {
                    getAddress(latitude: self.lastLatitude, longitude: self.lastLongitude)
                    funCompanyInfo()
                    funVisitPurpose()
                    
                    if LastCheckIn.count==0{
                        funLastCheckIn()
                    }
                })
                }
            }
            
            if compTypeX >= 0 {
                CompanyTypePopUp(funCompanyInfo: { self.funCompanyInfo() }, x: $compTypeX, CompanyTypeVal: $CompanyTypeVal, CompanyTypeName:$CompanyTypeName, CompanyTypeList: $CmpanyTypesList)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height-50, alignment: .center)
                .shadow(color: Color.black.opacity(compTypeX != 0 ? 0.1 : 0), radius: 5, x: 5, y: 0)
                .offset(x: compTypeX, y: 0)
                .background(Color.black.opacity(compTypeX == 0 ? 0.5 : 0)
                .onTapGesture {
                    self.compTypeX = -800
                })
            }
            
            if compX >= 0 {
                CompanyPopUp(x: $compX, CompanyVal: $CompanyVal, CompanyName:$CompanyName, CompanyAddress:$CompanyAddress, CurrentDataList: $CompanyList)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height-50, alignment: .center)
                .shadow(color: Color.black.opacity(compX != 0 ? 0.1 : 0), radius: 5, x: 5, y: 0)
                .offset(x: compX, y: 0)
                .background(Color.black.opacity(compX == 0 ? 0.5 : 0)
                .onTapGesture {
                    self.compX = -800
                })
            }
            
            if visitPurX >= 0 {
                VisitPurposePopUp(x: $visitPurX, VisitPurposeVal: $VisitPurposeVal, VisitPurposeName: $VisitPurposeName, CurrentDataList: $VisitPurposeList)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height-50, alignment: .center)
                .shadow(color: Color.black.opacity(visitPurX != 0 ? 0.1 : 0), radius: 5, x: 5, y: 0)
                .offset(x: visitPurX, y: 0)
                .background(Color.black.opacity(visitPurX == 0 ? 0.5 : 0)
                .onTapGesture {
                    self.visitPurX = -800
                })
            }
        }
        .keyboardAdaptive()
//        .offset(y: (self.value>0 ? (xheight > 880 ? 0 : xheight > 810 ? 31: xheight > 730 ? 26: xheight > 700 ? 0: xheight > 660 ? 0: 55): 0))
    }
    
    @State var xheight: CGFloat = UIScreen.main.bounds.height
    @State var value: CGFloat = 0
    @State var isLoaded: Bool = false
    
    @State var CompanyList: [CompanyInfo] = [CompanyInfo]()
    
    func funCompanyInfo() {
        guard let url = URL(string: baseUrl+"/api/EB_AMS_User/Get_Company") else { return }
        
        let defaults = UserDefaults.standard
        
        let Login_Name = defaults.string(forKey: defaultsKeys.Login_Name)!
        let Access_Key = defaults.string(forKey: defaultsKeys.Access_Key)!
        let compTypeId: Int = self.CompanyTypeVal
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let postString = "{'USER_NAME':'\(Login_Name)','ACCESS_KEY':'\(Access_Key)','COMPANY_TYPE_ID':'\(compTypeId)'}";
        // Set HTTP Request Body
        request.httpBody = postString.data(using: String.Encoding.utf8);
        
        self.CompanyList.removeAll()
        self.CompanyVal=0
        self.CompanyName=""
        self.CompanyAddress=""
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                return
            }
            if let dataString = String(data: data, encoding: .utf8) {
                print("Response data string:\n \(dataString)")
                let decoder = JSONDecoder()

                do {
                    let resData = try decoder.decode([CompanyInfo].self, from: data)
                    print(resData)
                    for i in 0...resData.count-1 {
                        self.CompanyList.append(resData[i])
                    }
                } catch {
                    print(error.localizedDescription)
                }
                
            }
        }
        .resume()
    }
    
    
    @State var VisitPurposeList: [VisitPurpose] = [VisitPurpose]()
    
    func funVisitPurpose() {
        guard let url = URL(string: baseUrl+"/api/EB_AMS_User/Get_Visit_Purpose") else { return }
        
        let defaults = UserDefaults.standard
        
        let Login_Name = defaults.string(forKey: defaultsKeys.Login_Name)!
        let Access_Key = defaults.string(forKey: defaultsKeys.Access_Key)!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let postString = "{'USER_NAME':'\(Login_Name)','ACCESS_KEY':'\(Access_Key)'}";
        // Set HTTP Request Body
        request.httpBody = postString.data(using: String.Encoding.utf8);
        
        self.VisitPurposeList.removeAll()
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                return
            }
            if let dataString = String(data: data, encoding: .utf8) {
                print("Response data string:\n \(dataString)")
                let decoder = JSONDecoder()

                do {
                    let resData = try decoder.decode([VisitPurpose].self, from: data)
                    print(resData)
                    for i in 0...resData.count-1 {
                        self.VisitPurposeList.append(resData[i])
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
                        self.CompanyTypeVal = resData.COMPANY_TYPE_ID
                        self.CompanyTypeName = String(resData.COMPANY_TYPE)
                        self.CompanyVal = resData.COMPANY_ID
                        self.CompanyName = String(resData.COMPANY_NAME)
                        self.CompanyAddress = String(resData.COMPANY_ADDRESS)
                        
                        self.lastLatitude = Double(resData.CHECK_IN_LATITUDE)
                        self.lastLongitude = Double(resData.CHECK_IN_LONGITUDE)
                        self.UserAddress = String(resData.CHECK_IN_ADDRESS)
                        
                        self.VisitPurposeVal = resData.VISIT_PURPOSE_ID
                        self.VisitPurposeName = String(resData.VISIT_PURPOSE)
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        .resume()
    }
    
    
    func funSaveCheckIn() {
        self.isLoad.toggle()
        guard let url = URL(string: baseUrl+"/api/EB_AMS_User/Save_Check_In") else { return }
        
        let defaults = UserDefaults.standard
        
        let Login_Name = defaults.string(forKey: defaultsKeys.Login_Name)!
        let Access_Key = defaults.string(forKey: defaultsKeys.Access_Key)!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let postString = "{'USER_NAME':'\(Login_Name)','ACCESS_KEY':'\(Access_Key)','COMPANY_TYPE_ID':'\(CompanyTypeVal)', 'COMPANY_ID':'\(self.CompanyVal)','COMPANY_NAME':'\(self.CompanyName)','COMPANY_ADDRESS':'\(self.CompanyAddress)', 'CHECK_IN_STATUS':'\(1)','CHECK_IN_LATITUDE':'\(self.lastLatitude)','CHECK_IN_LONGITUDE':'\(self.lastLongitude)', 'CHECK_IN_ADDRESS':'\(self.UserAddress)','VISIT_PURPOSE_ID': '\(VisitPurposeVal)'}";
        // Set HTTP Request Body
        request.httpBody = postString.data(using: String.Encoding.utf8);
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                return
            }
            if let dataString = String(data: data, encoding: .utf8) {
                print("Response data string:\n \(dataString)")
                let decoder = JSONDecoder()

                do {
                    
                    let resData = try decoder.decode(SaveInfo.self, from: data)
                    self.isLoad.toggle()
                    self.isToast.toggle()
                    self.msg = resData.message
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4), execute: {
                       
                        if resData.success == true {
                            
                            LastCheckIn.removeAll()
                            funLastCheckIn()
                            self.CompanyTypeVal = 0
                            self.CompanyTypeName = ""
                            self.CompanyVal = 0
                            self.CompanyName = ""
                            self.CompanyAddress = ""
                            
                            self.lastLatitude = 0.0
                            self.lastLongitude = 0.0
                            self.UserAddress = ""
                            
                            self.VisitPurposeVal = 0
                            self.VisitPurposeName = ""
                        }
                        
                       self.isToast.toggle()
                    })
                    
                } catch {
                    print(error.localizedDescription)
                    self.isLoad.toggle()
                }
            }
        }
        .resume()
    }
    
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

//Afzal
