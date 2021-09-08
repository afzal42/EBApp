//
//  checkOutUIView.swift
//  EBApp
//
//  Created by Md. Afzal Hossain on 8/28/21.
//

import SwiftUI
import GoogleMaps
import Combine

struct CheckOutUIView: View {
    
    @Binding var index: Int
    @Binding var title: String
    @Binding var lastPageIdx: Int
    @Binding var lastPageArray: [Int]
    @State var lastLatitude : Double
    @State var lastLongitude : Double
    
    @State var isToast: Bool = false
    @State var msg: String = ""
    
    @State var CompanyTypeVal:Int=0
    @State var CompanyType: String=""
    @State var CompanyVal:Int=0
    @State var CompanyName: String=""
    @State var CompanyAddress: String=""
    @State var Longitude: String=""
    @State var Latitude: String=""
    @State var UserAddress: String=""
    @State var VisitPurposeVal:Int=0
    @State var VisitPurposeName: String=""
    @State var VisitOutcomeName: String=""
    @State var VisitOutcomeVal:Int=0
    @State var UserRemarks: String=""
    @State var isLoad: Bool = false
    
    @State var xheight: CGFloat = UIScreen.main.bounds.height
    @State var value: CGFloat = 0
    @State var isLoaded: Bool = false
    
    @State var ddlOut: CGFloat = -1000
    
    func getAddress(latitude: Double, longitude: Double){
        let geocoder = GMSGeocoder()
        let coordinate = CLLocationCoordinate2DMake(Double(self.lastLatitude), Double(self.lastLongitude))
        
        geocoder.reverseGeocodeCoordinate(coordinate) { response , error in
            if let address = response?.firstResult() {
                self.UserAddress = address.lines![0]
            }
        }
    }
    
    var body: some View {
        
        ZStack{
            LoadingView(isShowing: $isLoad) {
                ToastView(isShowing: $isToast, message:$msg) {
                    ZStack{
                        ScrollView {
                            VStack(alignment:.leading, spacing:10){
                                VStack{
                                    HStack{
                                        
                                        Text("Company Type")
                                            .font(.system(size:14))
                                            .foregroundColor(Color("IconColor"))
                                        
                                        Spacer()
                                        HStack{
                                            
                                            HStack{
                                                
                                                Text(String(self.CompanyType))
                                                    .foregroundColor(Color("IconColor"))
                                                    .font(.system(size: 12))
                                                    .frame(width: 176,alignment: .leading)
                                                    .padding(.leading,5)
                                            }
                                            .overlay(
                                                Rectangle().frame(height: 1.0, alignment: .bottom).padding(.top, 30)
                                            )
                                        }
                                        .overlay(
                                            Rectangle().frame(height: 1.0, alignment: .bottom).padding(.top, 30)
                                        )
                                    }
                                    .padding(.leading, 20)
                                    .padding(.trailing, 20)
                                    .padding(.top, 20)
        //                            .background(Color("BarColor"))
                                    
                                    HStack{
                                        
                                        Text("Company Name")
                                            .font(.system(size:14))
                                            .foregroundColor(Color("IconColor"))
                                        
                                        Spacer()
                                        HStack{
                                            
    //                                        Text(self.CompanyName)
    //                                            .foregroundColor(Color("IconColor"))
    //                                            .font(.system(size: 12))
    //                                            .disableAutocorrection(true)
    //                                            .frame(width: 176)
    //                                            .padding(.leading,5)
    //                                            .disabled(true)
                                            
                                                TextField("", text: $CompanyName)
                                                    .foregroundColor(Color("IconColor"))
                                                    .font(.system(size: 12))
                                                    .disableAutocorrection(true)
                                                    .frame(width: 176)
                                                    .padding(.leading,5)
                                                    .disabled(true)
                                            
                                        }
                                        .overlay(
                                            Rectangle().frame(height: 1.0, alignment: .bottom).padding(.top, 30)
                                        )
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
                                                    .foregroundColor(Color("IconColor"))
                                                    .font(.system(size: 12))
                                                    .frame(width: 180, height: 60)
                                                    .disableAutocorrection(true)
                                                    .cornerRadius(8)
                                                    .disabled(true)
                                                
                                            } else {
                                                MultilineTextView(text: $CompanyAddress)
                                                    .foregroundColor(Color("IconColor"))
                                                    .font(.system(size: 12))
                                                    .frame(width: 180, height: 60)
                                                    .disableAutocorrection(true)
                                                    .cornerRadius(8)
                                                    .disabled(true)
                                            }
                //                            Text(self.CompanyAddress)
                //                                .font(.system(size: 12))
                //                                .disableAutocorrection(true)
                //                                .frame(width: 176)
                //                                .padding(.leading,5)
                                            
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
                                
                                VStack{
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
                                                .disabled(true)
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
                                                .disabled(true)
                                            
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
                //                            Text(self.UserAddress)
                //                                .font(.system(size: 12))
                //                                .frame(width: 176,alignment: .leading)
                //                                .padding(.leading,5)
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

                                            Text(self.VisitPurposeName)
                                                .foregroundColor(Color("IconColor"))
                                                .font(.system(size: 12))
                                                .frame(width: 176,alignment: .leading)
                                                .padding(.leading,5)
                                                .disabled(true)
                                        }
                                        .overlay(
                                            Rectangle().frame(height: 1.0, alignment: .bottom).padding(.top, 30)
                                        )
                                    }
                                    .padding(.leading, 20)
                                    .padding(.trailing, 20)
                                    .padding(.top, 10)

                                    HStack{

                                        Text("Visit Outcome")
                                            .font(.system(size:14))
                                            .foregroundColor(Color("IconColor"))

                                        Spacer()
                                        HStack{

                                            TextField("Visit Outcome", text: $VisitOutcomeName)
                                                .foregroundColor(Color("IconColor"))
                                                .font(.system(size: 12))
                                                .disableAutocorrection(true)
                                                .onTapGesture(perform: {
                                                    self.hideKeyboard()
                                                    ddlOut = 0
                                                })
                                                .frame(width: 150)
                                                .padding(.leading,5)
                                            Image(systemName: "chevron.down")
                                                .overlay(
                                                    Rectangle().frame(height: 1.0, alignment: .bottom).padding(.top, 30)
                                                )
                                                .onTapGesture(perform: {
                                                    ddlOut = 0
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

                                        Text("Remarks")
                                            .font(.system(size:14))
                                            .foregroundColor(Color("IconColor"))

                                        Spacer()
                                        HStack{
                                            if #available(iOS 14.0, *) {
                                                TextEditor(text: $UserRemarks)
                                                    .foregroundColor(Color("IconColor"))
                                                    .font(.system(size: 12))
                                                    .frame(width: 180, height: 60)
                                                    .disableAutocorrection(true)
                                                    .cornerRadius(8)
                                                    .onReceive(Just(self.UserRemarks)) { inputValue in
                                                           
                                                        if inputValue.count > 150 {
                                                            self.UserRemarks.removeLast()
                                                        }
                                                    }
                                                
                                            } else {
                                                MultilineTextView(text: $UserRemarks)
                                                    .foregroundColor(Color("IconColor"))
                                                    .font(.system(size: 12))
                                                    .frame(width: 180, height: 60)
                                                    .disableAutocorrection(true)
                                                    .cornerRadius(8)
                                                    .onReceive(Just(self.UserRemarks)) { inputValue in
                                                           
                                                        if inputValue.count > 150 {
                                                            self.UserRemarks.removeLast()
                                                        }
                                                    }
                                            }
                //                            TextField("", text: $UserRemarks)
                //                                .font(.system(size: 12))
                //                                .disableAutocorrection(true)
                //                                .frame(width: 176)
                //                                .padding(.leading,5)
                                            
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
                                        Text(String(self.UserRemarks.count)+"/150")
                                            .font(.system(size:10))
                                            .foregroundColor(Color("IconColor"))
                                    }
                                    .padding(.leading, 20)
                                    .padding(.trailing, 20)
                                    .padding(.top, 0)
                                    
                                    HStack{
                                        Spacer(minLength: 0)
                                        Button(action: {
                                            if self.VisitOutcomeName.count>1 && self.lastLatitude>1 && self.lastLongitude>1 && self.UserAddress.count>1 && self.UserRemarks.count>1{
                                                self.funSaveCheckOut()
                                            }
                                            else{
                                                self.msg="You Select All Value Properly!!"
                                                self.isToast.toggle()
                                                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
                                                    self.isToast.toggle()
                                                })
                                            }
                                        }, label: {
                                            Text("Check-Out")
                                            .fontWeight(.bold)
                                            .frame(height: 25)
                                            .padding(.leading,10).padding(.trailing,10)
                                            .padding(5)
                                            .foregroundColor(Color.white)
                                        })
                                        .background(Color("btnColor"))
                                        .cornerRadius(3)
                                        .disabled(LastCheckIn.count==0 ? true:false)
                                        
                                        Spacer(minLength: 0)
                                    }
                                    .padding(.top, 20)
                                    Spacer()
                            }
                        }
                    }
                    .onAppear(perform: {
                        getAddress(latitude: self.lastLatitude, longitude: self.lastLongitude)
                        funVisitOutcome()
    //                    if LastCheckIn.count==0{
                            funLastCheckIn()
    //                    }
                    })
                        
                }
                }
            }
            
            if ddlOut >= 0 {
                VisitOutcomesPopUp(x: $ddlOut, VisitOutcomeVal: $VisitOutcomeVal, VisitOutcomeName: $VisitOutcomeName, CurrentDataList: $VisitOutcomeList)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height-50, alignment: .center)
                .shadow(color: Color.black.opacity(ddlOut != 0 ? 0.1 : 0), radius: 5, x: 5, y: 0)
                .offset(x: ddlOut, y: 0)
                .background(Color.black.opacity(ddlOut == 0 ? 0.5 : 0)
                .onTapGesture {
                    self.ddlOut = -800
                })
            }
        }
        
        .keyboardAdaptive()
    }

    
    
    
    @State var VisitOutcomeList: [VisitOutcome] = [VisitOutcome]()
    
    func funVisitOutcome() {
        guard let url = URL(string: baseUrl+"/api/EB_AMS_User/Get_Visit_Outcome") else { return }
        
        let defaults = UserDefaults.standard
        
        let Login_Name = defaults.string(forKey: defaultsKeys.Login_Name)!
        let Access_Key = defaults.string(forKey: defaultsKeys.Access_Key)!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let postString = "{'USER_NAME':'\(Login_Name)','ACCESS_KEY':'\(Access_Key)'}";
        // Set HTTP Request Body
        request.httpBody = postString.data(using: String.Encoding.utf8);
        
        self.VisitOutcomeList.removeAll()
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                return
            }
            if let dataString = String(data: data, encoding: .utf8) {
                print("Response data string:\n \(dataString)")
                let decoder = JSONDecoder()

                do {
                    let resData = try decoder.decode([VisitOutcome].self, from: data)
                    print(resData)
                    for i in 0...resData.count-1 {
                        self.VisitOutcomeList.append(resData[i])
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
                        self.CompanyType = String(resData.COMPANY_TYPE)
                        self.CompanyVal = resData.COMPANY_ID
                        self.CompanyName = String(resData.COMPANY_NAME)
                        self.CompanyAddress = String(resData.COMPANY_ADDRESS)
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
    
    
    func funSaveCheckOut() {
        self.isLoad.toggle()
        guard let url = URL(string: baseUrl+"/api/EB_AMS_User/Save_Check_Out") else { return }
        
        let defaults = UserDefaults.standard
        
        let Login_Name = defaults.string(forKey: defaultsKeys.Login_Name)!
        let Access_Key = defaults.string(forKey: defaultsKeys.Access_Key)!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let postString = "{'USER_NAME':'\(Login_Name)','ACCESS_KEY':'\(Access_Key)','COMPANY_ID':'\(self.CompanyVal)', 'CHECK_OUT_STATUS':'\(1)','CHECK_OUT_LATITUDE':'\(self.lastLatitude)','CHECK_OUT_LONGITUDE':'\(self.lastLongitude)', 'CHECK_OUT_ADDRESS':'\(self.UserAddress)','VISIT_OUTCOME_ID': '\(VisitOutcomeVal)','CHECK_OUT_REMARKS':'\(self.UserRemarks)'}";
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
                        self.CompanyTypeVal = 0
                        self.CompanyType = ""
                        self.CompanyVal = 0
                        self.CompanyName = ""
                        self.CompanyAddress = ""
                        
    //                    self.lastLatitude = 0.0
    //                    self.lastLongitude = 0.0
    //                    self.UserAddress = ""
                        
                        self.VisitPurposeVal = 0
                        self.VisitPurposeName = ""
                        self.VisitOutcomeVal = 0
                        self.VisitOutcomeName = ""
                        self.UserRemarks = ""
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

//Afzal
