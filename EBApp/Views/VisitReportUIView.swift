//
//  VisitReportUIView.swift
//  EBApp
//
//  Created by Md. Afzal Hossain on 9/6/21.
//

import SwiftUI

struct VisitReportUIView: View {
    @Binding var index: Int
    @Binding var lastPageIdx: Int
    @Binding var lastPageArray: [Int]
    @Binding var title: String
    
    @State var Target_Count: Double = 0
    @State var Achievment_Count: Double = 0
    @State var Last_Update_Date: String = ""
    
    @State private var dtFromDate = Date()
    @State private var dtToDate = Date()
    @State var fromDate:String = ""
    @State var toDate:String = ""
    
    @State var isLoad: Bool = false
    
    @State var tableHeader = ["Company Name","Company Type","Check-In","Check-Out","Purpose"]
    @State var tableHeaderCom = ["Company ID","Company Name","No. of Visit"]
    @State var tableHeaderZero = ["Company ID","Company Name"]
    @State var dtFrmX: CGFloat = -1000
    @State var dtToX: CGFloat = -1000
    
    let formatter = DateFormatter()
    
    static let taskDateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }()
    
    var today = Date()
    var dueDate = Calendar.current.date(byAdding: .day, value: -1, to: Date())
    
    @State var CheckInList = [CheckinInfo]()
    
    @State var CompanyVisitList = [CompanyVisit]()
    @State var ZeroCompanyList = [ZeroCompany]()
    
    
    func funVisitHistory() {
//        guard let url = URL(string: baseUrl+"/api/EB_AMS_User/Get_CheckIn_CheckOut_History") else { return }
        guard let url = URL(string: baseUrl+"/api/EB_AMS_User/"+(self.VisitTypeId==0 ? "Get_CheckIn_CheckOut_History": self.VisitTypeId==1 ? "Get_Company_Wise_Visit":"Get_Zero_Company_Visit")) else { return }
        
        let defaults = UserDefaults.standard
        
        let Login_Name = defaults.string(forKey: defaultsKeys.Login_Name)!
        let Access_Key = defaults.string(forKey: defaultsKeys.Access_Key)!
        
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "dd/M/yyyy"
        let fromDT = inputFormatter.string(from: self.dtFromDate)
        let toDT = inputFormatter.string(from: self.dtToDate)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let postString = "{'USER_NAME':'\(Login_Name)','ACCESS_KEY':'\(Access_Key)','START_DATE': '\(fromDT)','END_DATE': '\(toDT)'}";
        // Set HTTP Request Body
        request.httpBody = postString.data(using: String.Encoding.utf8);
        
        self.CheckInList.removeAll()
        self.CompanyVisitList.removeAll()
        self.ZeroCompanyList.removeAll()
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                return
            }
            if let dataString = String(data: data, encoding: .utf8) {
//                print("Response data string:\n \(dataString)")
                let decoder = JSONDecoder()

                do {
                    if dataString.count > 5 {
                        if self.VisitTypeId == 0 {
                            let resData = try decoder.decode([CheckInHistoryX].self, from: data)
//                            print(resData)
                            for i in 0...resData.count-1 {
                                let obj = resData[i]
                                self.CheckInList.append(CheckinInfo.init(SL: i, COMPANY_TYPE_ID: obj.COMPANY_TYPE_ID, COMPANY_TYPE: obj.COMPANY_TYPE, COMPANY_ID: obj.COMPANY_ID, COMPANY_NAME: obj.COMPANY_NAME, COMPANY_ADDRESS: obj.COMPANY_ADDRESS, CHECK_IN_STATUS: obj.CHECK_IN_STATUS, CHECK_IN_DATE: obj.CHECK_IN_DATE, CHECK_IN_LATITUDE: obj.CHECK_IN_LATITUDE, CHECK_IN_LONGITUDE: obj.CHECK_IN_LONGITUDE, CHECK_IN_ADDRESS: obj.CHECK_IN_ADDRESS, VISIT_PURPOSE_ID: obj.VISIT_PURPOSE_ID, VISIT_PURPOSE: obj.VISIT_PURPOSE ?? "", CHECK_OUT_STATUS: obj.CHECK_OUT_STATUS, CHECK_OUT_DATE: obj.CHECK_OUT_DATE, CHECK_OUT_LATITUDE: obj.CHECK_OUT_LATITUDE, CHECK_OUT_LONGITUDE: obj.CHECK_OUT_LONGITUDE, CHECK_OUT_ADDRESS: obj.CHECK_OUT_ADDRESS, VISIT_OUTCOME_ID: obj.VISIT_OUTCOME_ID, VISIT_OUTCOME: obj.VISIT_OUTCOME, CHECK_OUT_REMARKS: obj.CHECK_OUT_REMARKS, SUCCCESS: true))
                            }
                        }
                        else if self.VisitTypeId == 1 {
                            let resData = try decoder.decode([CompanyVisitX].self, from: data)
                            print(resData)
                            for i in 0...resData.count-1 {
                                let obj=resData[i]
                                self.CompanyVisitList.append(CompanyVisit.init(SL: i, COMPANY_ID: obj.COMPANY_ID, COMPANY_NAME: obj.COMPANY_NAME, NO_OF_VISIT: obj.NO_OF_VISIT))
                            }
                        }
                        else if self.VisitTypeId == 2 {
                            let resData = try decoder.decode([ZeroCompanyX].self, from: data)
                            print(resData)
                            for i in 0...resData.count-1 {
                                let obj=resData[i]
                                self.ZeroCompanyList.append(ZeroCompany.init(SL: i, COMPANY_ID: obj.COMPANY_ID, COMPANY_NAME: obj.COMPANY_NAME))
                            }
                        }
                    }
                    self.isLoad.toggle()
                } catch {
                    print(error.localizedDescription)
                    self.isLoad.toggle()
                }
                
            }
        }
        .resume()
    }
    
    @State var VisitTypeList:[VisitTypeInfo] = [
        .init(VISIT_TYPE_ID:0, VISIT_TYPE_NAME:"Day Wise Visit"),
        .init(VISIT_TYPE_ID:1, VISIT_TYPE_NAME:"Company Wise Visit"),
        .init(VISIT_TYPE_ID:2, VISIT_TYPE_NAME:"Zero Company Visit")
    ]
    @State var VisitTypeName: String="Day Wise Visit"
    @State var VisitTypeId: Int=0
    
    var body: some View {
        ZStack{
            LoadingView(isShowing: $isLoad) {
                ZStack{
                    VStack(spacing:0){
                        VStack{
                            
                            HStack{
                                HStack{
                                    Text("Visit Type")
                                        .font(.system(size: 14))
                                }
                                Spacer()
                                
                                HStack{
                                    
                                    if #available(iOS 14.0, *) {
                                        Menu {
                                            ForEach(self.VisitTypeList, id: \.VISIT_TYPE_ID) { item in
                                                Button(action: {
                                                    self.VisitTypeName = item.VISIT_TYPE_NAME
                                                    self.VisitTypeId = item.VISIT_TYPE_ID
                                                    print(item.VISIT_TYPE_NAME)
//                                                    self.loadCampaignPerformance()
                                                }) {
                                                    PopUpButton(title: item.VISIT_TYPE_NAME)
                                                }
                                            }
                                            
                                        } label: {
                                            HStack{
                                                Text(VisitTypeName)
                                                    .font(.system(size: 14))
//                                                    .foregroundColor(.black)
                                                Image(systemName: "chevron.down")
                                                
                                            }
                                            .foregroundColor(Color("IconColor"))
                                            .overlay(
                                                Rectangle().frame(height: 1.0, alignment: .bottom).padding(.top, 30).foregroundColor(Color("IconColor"))
                                            )
                                        }

                                    } else {
                                        Image(systemName: "chevron.down").contextMenu {
                                            ForEach(self.VisitTypeList, id: \.VISIT_TYPE_ID) { item in
                                                Button(action: {
                                                    self.VisitTypeName = item.VISIT_TYPE_NAME
                                                    self.VisitTypeId = item.VISIT_TYPE_ID
                                                    print(item.VISIT_TYPE_NAME)
//                                                    self.loadCampaignPerformance()
                                                }) {
                                                    PopUpButton(title: item.VISIT_TYPE_NAME)
                                                }
                                            }
                                        }
                                    }
                                }
//                                .padding(.trailing, 10)
                                
                            }
//                            .padding(.leading, 10)
//                            .padding(.trailing, 10)
                            .padding(5)
                            
                            
                            HStack{
                                HStack{
                                    Text("From:").foregroundColor(Color.gray)
                                        .font(.system(size: 14))
                                    Text("\(dtFromDate, formatter: Self.taskDateFormat)")
                                        .font(.system(size: 14))
                                        .fontWeight(.medium)
                                    .onTapGesture(perform: {
                                        dtFrmX = 0
                                    })
                                    Image(systemName: "calendar").frame(width: 10, height: 10)
                                }
                                Spacer(minLength: 0)
                                HStack{
                                    Text("To:").foregroundColor(Color.gray)
                                        .font(.system(size: 14))
                                    Text("\(dtToDate, formatter: Self.taskDateFormat)")
                                        .font(.system(size: 14))
                                        .fontWeight(.medium)
                                    .onTapGesture(perform: {
                                        dtToX = 0
                                    })
                                    Image(systemName: "calendar").frame(width: 10, height: 10)
                                }
                                
                            }
                            .padding(5)
                            .padding(.top, 10)
                        
                            HStack{
                                Button(action: {
                                    self.isLoad.toggle()
                                    self.funVisitHistory()
                                }, label: {
                                    Text("Search")
                                    .fontWeight(.bold)
                                    .frame(width: (UIScreen.main.bounds.width - 100), height: 20)
                                    .padding(.leading,10).padding(.trailing,10)
                                    .padding(10)
                                    .foregroundColor(Color.white)
                                })
                                .background(Color("btnColor"))
                                .cornerRadius(3)
                            }
                            .padding(.top, 5)
                        }
                        .padding(10)
                        
                        
                        HStack{
//                            HStack{
//                            Image("disclaimer2").foregroundColor(Color.red)
//                            }
//                            Spacer()
//                            HStack{
//                                Image("calendar")
//                                Text("\(dueDate!, formatter: Self.taskDateFormat)")
//                                    .font(.system(size: 12))
//                            }
//                            .padding(.trailing, 10)
//                            .padding(.bottom, 5)
                        }
                        .background(Color("IconColor").opacity(0.2))
                        .overlay(
                            RoundedRectangle(cornerRadius: 0)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                        
                        HStack{
                            
                            if self.VisitTypeId == 0 {
                                
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
                            else if self.VisitTypeId == 1 {
                                ForEach(self.tableHeaderCom, id:\.self){i in
                                    HStack{
                                        Text(i)
                                            .fontWeight(.bold)
                                            .font(.system(size: 10)).multilineTextAlignment(.center)
                                    }.frame(width: UIScreen.main.bounds.width/3.5)
                                    
                                    Spacer(minLength: 1)
                                }
                            }
                            else if self.VisitTypeId == 2 {
                                ForEach(self.tableHeaderZero, id:\.self){i in
                                    HStack{
                                        Text(i)
                                            .fontWeight(.bold)
                                            .font(.system(size: 10)).multilineTextAlignment(.center)
                                    }.frame(width: UIScreen.main.bounds.width/2.5)
                                    
                                    Spacer(minLength: 1)
                                }
                            }
                        }
                        .padding(5)
                        .padding(.top, 10)
                        .padding(.bottom, 10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 0)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                        VStack{
                            
                            ScrollView(.vertical, showsIndicators: false) {
                                
                                if self.VisitTypeId == 0 {
                                    
                                    ForEach(self.CheckInList, id:\.SL){i in
                                        HStack{
                                            HStack{
                                                Text(i.COMPANY_NAME)
                                                    .fontWeight(.bold)
                                                    .font(.system(size: 10)).multilineTextAlignment(.leading)
                                                Spacer(minLength: 0)
                                            }.frame(width: UIScreen.main.bounds.width/5.5)
                                            .padding(.leading, 5)
                                            
                                            HStack{
                                                Text(i.COMPANY_TYPE)
                                                    .fontWeight(.bold)
                                                    .font(.system(size: 10)).multilineTextAlignment(.center)
                                            }.frame(width: UIScreen.main.bounds.width/5.5)
    
                                            HStack{
                                                Text(i.CHECK_IN_DATE)
                                                    .fontWeight(.bold)
                                                    .font(.system(size: 10)).multilineTextAlignment(.center)
                                            }.frame(width: UIScreen.main.bounds.width/5.5)
    
                                            HStack{
                                                Text(String(i.CHECK_OUT_DATE ?? ""))
                                                    .fontWeight(.bold)
                                                    .font(.system(size: 10)).multilineTextAlignment(.center)
                                            }.frame(width: UIScreen.main.bounds.width/5.5)
    
                                            HStack{
                                                Text(i.VISIT_PURPOSE)
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
                                else if self.VisitTypeId == 1 {

                                    ForEach(self.CompanyVisitList, id:\.SL){i in
                                        HStack{
                                            HStack{
                                                Spacer(minLength: 0)
                                                Text(String(i.COMPANY_ID))
                                                    .fontWeight(.bold)
                                                    .font(.system(size: 10)).multilineTextAlignment(.leading)
                                                Spacer(minLength: 0)
                                            }.frame(width: UIScreen.main.bounds.width/3.5)
                                            .padding(.leading, 5)
                                            
                                            Spacer()
                                            HStack{
                                                Text(i.COMPANY_NAME)
                                                    .fontWeight(.bold)
                                                    .font(.system(size: 10)).multilineTextAlignment(.center)
                                                Spacer(minLength: 0)
                                            }.frame(width: UIScreen.main.bounds.width/3.5)
                                            
                                            Spacer()

                                            HStack{
                                                Spacer(minLength: 0)
                                                Text(String(i.NO_OF_VISIT))
                                                    .fontWeight(.bold)
                                                    .font(.system(size: 10)).multilineTextAlignment(.leading)
                                                Spacer(minLength: 0)
                                            }.frame(width: UIScreen.main.bounds.width/3.5)
//                                            .padding(.trailing, 20)
                                        }
                                        .padding(.top,5)
                                        .padding(.bottom,5)
                                        .background(Color("IconColor").opacity(i.SL % 2 == 0 ? 0.1 : 0))
                                    }
                                }
                                else if self.VisitTypeId == 2 {

                                    ForEach(self.ZeroCompanyList, id:\.SL){i in
                                        HStack{
                                            
                                            HStack{
                                                Spacer(minLength: 0)
                                                Text(String(i.COMPANY_ID))
                                                    .fontWeight(.bold)
                                                    .font(.system(size: 10)).multilineTextAlignment(.leading)
                                                Spacer(minLength: 0)
                                            }.frame(width: UIScreen.main.bounds.width/2.5)
                                            .padding(.leading, 20)
    
                                            Spacer()
                                            HStack{
                                                Text(i.COMPANY_NAME)
                                                    .fontWeight(.bold)
                                                    .font(.system(size: 10)).multilineTextAlignment(.center)
                                                Spacer(minLength: 0)
                                            }.frame(width: UIScreen.main.bounds.width/2.5)
                                            
                                        }
                                        .padding(.top,5)
                                        .padding(.bottom,5)
                                        .background(Color("IconColor").opacity(i.SL % 2 == 0 ? 0.1 : 0))
                                    }
                                }
                            }
                        }
                        .padding(1)
                        
                        Spacer()
                    }
                    .onAppear(perform: {
//                        self.funVisitHistory()
                    })
                }
            }
             
            
            if self.dtFrmX >= 0 {
                XCalenderView(date: $dtFromDate, x:$dtFrmX)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height-50, alignment: .center)
                .shadow(color: Color.black.opacity(dtFrmX != 0 ? 0.1 : 0), radius: 5, x: 5, y: 0)
                .offset(x: dtFrmX)
                .background(Color.black.opacity(dtFrmX == 0 ? 0.5 : 0)
                .onTapGesture {
                    dtFrmX = -800
                })
            }
            
            if self.dtToX >= 0 {
                XCalenderView(date: $dtToDate, x:$dtToX)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height-50, alignment: .center)
                .shadow(color: Color.black.opacity(dtToX != 0 ? 0.1 : 0), radius: 5, x: 5, y: 0)
                .offset(x: dtToX)
                .background(Color.black.opacity(dtToX == 0 ? 0.5 : 0)
                .onTapGesture {
                    dtToX = -800
                })
            }
        }
        
    }
}

//Afzal
