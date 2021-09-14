//
//  SalesUpdateUIView.swift
//  EBApp
//
//  Created by Md. Afzal Hossain on 9/6/21.
//

import SwiftUI

struct SalesUpdateUIView: View {
    @Binding var index: Int
    @Binding var lastPageIdx: Int
    @Binding var lastPageArray: [Int]
    @Binding var title: String
    
    
    @State private var dtFromDate = Date()
    @State private var dtToDate = Date()
    @State var fromDate:String = ""
    @State var toDate:String = ""
    
    @State var isLoad: Bool = false
    
    @State var tableHeader = ["Company ID","Company Name","Company Segment","Total MSISDN","BTRC Approval Status"]
    @State var tableHeaderCom = ["Company ID","Company Name","Company Type","No. of MSISDN","Expected Revenue","Team","Active Mature Month"]
    @State var dtFrmX: CGFloat = -1000
    @State var dtToX: CGFloat = -1000
    
    let formatter = DateFormatter()
    
    static let taskDateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = "yy"
        return formatter
    }()
    
    var today = Date()
    var dueDate = Calendar.current.date(byAdding: .day, value: -1, to: Date())
    
    @State var SalsePipelineList = [SalsePipeline]()
    
    func funSalesPipeline() {
        
        guard let url = URL(string: baseUrl+"/api/EB_AMS_User/Get_Sales_Pipeline_Update") else { return }
        let defaults = UserDefaults.standard
        
        let Login_Name = defaults.string(forKey: defaultsKeys.Login_Name)!
        let Access_Key = defaults.string(forKey: defaultsKeys.Access_Key)!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
//        let inputFormatter = DateFormatter()
//        inputFormatter.dateFormat = "_yy"
//        let year = inputFormatter.string(from: self.today)
//        print(year)
        
        let postString = "{'USER_NAME':'\(Login_Name)','ACCESS_KEY':'\(Access_Key)','MONTH_NAME': '\(self.MonthName)\("_"+String(self.YearID))'}";
        // Set HTTP Request Body
        request.httpBody = postString.data(using: String.Encoding.utf8);
        
        self.SalsePipelineList.removeAll()
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                return
            }
            if let dataString = String(data: data, encoding: .utf8) {
//                print("Response data string:\n \(dataString)")
                let decoder = JSONDecoder()

                do {
                    let resData = try decoder.decode([SalsePipelineX].self, from: data)
                    if dataString != "[]"{
//                        print(resData)
                        for i in 0...resData.count-1 {
                            let obj = resData[i]
                            self.SalsePipelineList.append(SalsePipeline.init(SL: i, COMPANY_ID: obj.COMPANY_ID, COMPANY_NAME: obj.COMPANY_NAME, COMPANY_TYPE: obj.COMPANY_TYPE, TOTAL_MSISDN_COUNT: obj.TOTAL_MSISDN_COUNT, EXPECTED_REVENUE: obj.EXPECTED_REVENUE, TEAM: obj.TEAM, ACTIVATION_MATURE_MONTH: obj.ACTIVATION_MATURE_MONTH))
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
    
    
    @State var AgreementInfoList = [AgreementInfo]()
    
    func funCorporateAgreement() {
        
        guard let url = URL(string: baseUrl+"/api/EB_AMS_User/Get_Corporate_Agreement") else { return }
        let defaults = UserDefaults.standard
        
        let Login_Name = defaults.string(forKey: defaultsKeys.Login_Name)!
        let Access_Key = defaults.string(forKey: defaultsKeys.Access_Key)!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
//        let inputFormatter = DateFormatter()
//        inputFormatter.dateFormat = "_yy"
//        let year = inputFormatter.string(from: self.today)
//        print(year)
        
        let postString = "{'USER_NAME':'\(Login_Name)','ACCESS_KEY':'\(Access_Key)','MONTH_NAME': '\(self.MonthName)\("_"+String(self.YearID))'}";
        // Set HTTP Request Body
        request.httpBody = postString.data(using: String.Encoding.utf8);
        
        self.AgreementInfoList.removeAll()
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                return
            }
            if let dataString = String(data: data, encoding: .utf8) {
//                print("Response data string:\n \(dataString)")
                let decoder = JSONDecoder()

                do {
                    let resData = try decoder.decode([AgreementInfoX].self, from: data)
                    if dataString != "[]"{
//                        print(resData)
                        for i in 0...resData.count-1 {
                            let obj = resData[i]
                            self.AgreementInfoList.append(AgreementInfo.init(SL: i, COMPANY_ID: obj.COMPANY_ID, COMPANY_NAME: obj.COMPANY_NAME, COMPANY_SEGMENT: obj.COMPANY_SEGMENT, TOTAL_MSISDN_COUNT: obj.TOTAL_MSISDN_COUNT, BTRC_APPROVAL_STATUS: obj.BTRC_APPROVAL_STATUS))
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
    
    @State var SalesTypeList:[VisitTypeInfo] = [
        .init(VISIT_TYPE_ID:0, VISIT_TYPE_NAME:"Corporate Agreement"),
        .init(VISIT_TYPE_ID:1, VISIT_TYPE_NAME:"Sales Pipeline Status")
    ]
    
    @State var MonthList:[VisitTypeInfo] = [
        .init(VISIT_TYPE_ID:1, VISIT_TYPE_NAME:"Jan"),
        .init(VISIT_TYPE_ID:2, VISIT_TYPE_NAME:"Feb"),
        .init(VISIT_TYPE_ID:3, VISIT_TYPE_NAME:"Mar"),
        .init(VISIT_TYPE_ID:4, VISIT_TYPE_NAME:"Apr"),
        .init(VISIT_TYPE_ID:5, VISIT_TYPE_NAME:"May"),
        .init(VISIT_TYPE_ID:6, VISIT_TYPE_NAME:"Jun"),
        .init(VISIT_TYPE_ID:7, VISIT_TYPE_NAME:"Jul"),
        .init(VISIT_TYPE_ID:8, VISIT_TYPE_NAME:"Aug"),
        .init(VISIT_TYPE_ID:9, VISIT_TYPE_NAME:"Sep"),
        .init(VISIT_TYPE_ID:10, VISIT_TYPE_NAME:"Oct"),
        .init(VISIT_TYPE_ID:11, VISIT_TYPE_NAME:"Nov"),
        .init(VISIT_TYPE_ID:12, VISIT_TYPE_NAME:"Dec")
    ]
    
    @State var SalesTypeName: String="Corporate Agreement"
    @State var SalesTypeId: Int=0
    @State var MonthName: String="Jan"
    @State var MonthId: Int=1
    @State var YearName: String=""
    @State var YearID: Int=0
    @State var YearList = [YearInfo]()
    
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
                                            ForEach(self.SalesTypeList, id: \.VISIT_TYPE_ID) { item in
                                                Button(action: {
                                                    self.SalesTypeName = item.VISIT_TYPE_NAME
                                                    self.SalesTypeId = item.VISIT_TYPE_ID
                                                    print(item.VISIT_TYPE_NAME)
//                                                    self.loadCampaignPerformance()
                                                }) {
                                                    PopUpButton(title: item.VISIT_TYPE_NAME)
                                                }
                                            }
                                            
                                        } label: {
                                            HStack{
                                                Text(SalesTypeName)
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
                                            ForEach(self.SalesTypeList, id: \.VISIT_TYPE_ID) { item in
                                                Button(action: {
                                                    self.SalesTypeName = item.VISIT_TYPE_NAME
                                                    self.SalesTypeId = item.VISIT_TYPE_ID
                                                    print(item.VISIT_TYPE_NAME)
//                                                    self.loadCampaignPerformance()
                                                }) {
                                                    PopUpButton(title: item.VISIT_TYPE_NAME)
                                                }
                                            }
                                        }
                                    }
                                }
                                
                            }
                            .padding(5)
                            
                            HStack{
                                HStack{
                                    Text("Month")
                                        .font(.system(size: 14))
                                }
                                Spacer()
                                
                                HStack{
                                    
                                    if #available(iOS 14.0, *) {
                                        Menu {
                                            ForEach(self.MonthList, id: \.VISIT_TYPE_ID) { item in
                                                Button(action: {
                                                    self.MonthName = item.VISIT_TYPE_NAME
                                                    self.MonthId = item.VISIT_TYPE_ID
                                                    print(item.VISIT_TYPE_NAME)
//                                                    self.loadCampaignPerformance()
                                                }) {
                                                    PopUpButton(title: item.VISIT_TYPE_NAME)
                                                }
                                            }
                                            
                                        } label: {
                                            HStack{
                                                Text(MonthName)
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
                                            ForEach(self.MonthList, id: \.VISIT_TYPE_ID) { item in
                                                Button(action: {
                                                    self.MonthName = item.VISIT_TYPE_NAME
                                                    self.MonthId = item.VISIT_TYPE_ID
                                                    print(item.VISIT_TYPE_NAME)
//                                                    self.loadCampaignPerformance()
                                                }) {
                                                    PopUpButton(title: item.VISIT_TYPE_NAME)
                                                }
                                            }
                                        }
                                    }
                                }
                                
                            }
                            .padding(5)
                            
                            HStack{
                                HStack{
                                    Text("Year")
                                        .font(.system(size: 14))
                                }
                                Spacer()
                                
                                HStack{
                                    
                                    if #available(iOS 14.0, *) {
                                        Menu {
                                            ForEach(self.YearList, id: \.YEAR_ID) { item in
                                                Button(action: {
                                                    self.YearName = item.YEAR_NAME
                                                    self.YearID = item.YEAR_ID
                                                }) {
                                                    PopUpButton(title: item.YEAR_NAME)
                                                }
                                            }
                                            
                                        } label: {
                                            HStack{
                                                Text(YearName)
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
                                            ForEach(self.YearList, id: \.YEAR_ID) { item in
                                                Button(action: {
                                                    self.YearName = item.YEAR_NAME
                                                    self.YearID = item.YEAR_ID
                                                }) {
                                                    PopUpButton(title: item.YEAR_NAME)
                                                }
                                            }
                                        }
                                    }
                                }
                                
                            }
                            .padding(5)
                            
                            
                            
                            HStack{
                                Button(action: {
                                    self.isLoad.toggle()
                                    if self.SalesTypeId == 1 {
                                        self.funSalesPipeline()
                                    }
                                    else{
                                        self.funCorporateAgreement()
                                    }
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
                        }
                        .background(Color("IconColor").opacity(0.2))
                        .overlay(
                            RoundedRectangle(cornerRadius: 0)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                        
                        HStack{
                            
                            Spacer(minLength: 1)
                            if self.SalesTypeId == 0 {
                                ForEach(self.tableHeader, id:\.self){i in
                                    HStack{
                                        Text(i)
                                            .fontWeight(.bold)
                                            .font(.system(size: 10)).multilineTextAlignment(.center)
                                    }.frame(width: UIScreen.main.bounds.width/5.5)
                                    
                                    Spacer(minLength: 1)
                                }
                            }
                            else if self.SalesTypeId == 1 {
                                ForEach(self.tableHeaderCom, id:\.self){i in
                                    HStack{
                                        Text(i)
                                            .fontWeight(.bold)
                                            .font(.system(size: 10)).multilineTextAlignment(.center)
                                    }.frame(width: UIScreen.main.bounds.width/7.7)
                                    
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
                                if self.SalesTypeId == 0 {
                                    ForEach(self.AgreementInfoList, id:\.SL){i in
                                        HStack{
                                            HStack{
                                                Spacer(minLength: 0)
                                                Text(String(i.COMPANY_ID))
                                                    .fontWeight(.bold)
                                                    .font(.system(size: 10)).multilineTextAlignment(.leading)
                                                Spacer(minLength: 0)
                                            }.frame(width: UIScreen.main.bounds.width/6.2)
                                            .padding(.leading, 5)
    //
                                            HStack{
                                                Text(i.COMPANY_NAME)
                                                    .fontWeight(.bold)
                                                    .font(.system(size: 10)).multilineTextAlignment(.leading)
                                            }.frame(width: UIScreen.main.bounds.width/5.2)

                                            HStack{
                                                Text(i.COMPANY_SEGMENT)
                                                    .fontWeight(.bold)
                                                    .font(.system(size: 10)).multilineTextAlignment(.center)
                                            }.frame(width: UIScreen.main.bounds.width/5.5)
//
                                            HStack{
                                                Text(String(i.TOTAL_MSISDN_COUNT))
                                                    .fontWeight(.bold)
                                                    .font(.system(size: 10)).multilineTextAlignment(.center)
                                            }.frame(width: UIScreen.main.bounds.width/5.5)
//    //
                                            HStack{
                                                Text(i.BTRC_APPROVAL_STATUS)
                                                    .fontWeight(.bold)
                                                    .font(.system(size: 10)).multilineTextAlignment(.center)
                                            }.frame(width: UIScreen.main.bounds.width/5.5)
//    //
                                            Spacer()
                                        }
                                        .padding(.top,5)
                                        .padding(.bottom,5)
                                        .background(Color("IconColor").opacity(i.SL % 2 == 0 ? 0.1 : 0))
                                    }
                                }
                                else
                                {
                                    ForEach(self.SalsePipelineList, id:\.SL){i in
                                        HStack{
                                            HStack{
                                                Spacer(minLength: 0)
                                                Text(String(i.COMPANY_ID))
                                                    .fontWeight(.bold)
                                                    .font(.system(size: 10)).multilineTextAlignment(.leading)
                                                Spacer(minLength: 0)
                                            }.frame(width: UIScreen.main.bounds.width/8.5)
                                            .padding(.leading,0)
    //
                                            HStack{
                                                Text(i.COMPANY_NAME)
                                                    .fontWeight(.bold)
                                                    .font(.system(size: 10)).multilineTextAlignment(.leading)
                                            }.frame(width: UIScreen.main.bounds.width/7.5)

                                            HStack{
                                                Text(i.COMPANY_TYPE)
                                                    .fontWeight(.bold)
                                                    .font(.system(size: 10)).multilineTextAlignment(.center)
                                            }.frame(width: UIScreen.main.bounds.width/7.5)

                                            HStack{
                                                Text(String(i.TOTAL_MSISDN_COUNT))
                                                    .fontWeight(.bold)
                                                    .font(.system(size: 10)).multilineTextAlignment(.center)
                                            }.frame(width: UIScreen.main.bounds.width/8.5)
    //
                                            HStack{
                                                Text(String(i.EXPECTED_REVENUE))
                                                    .fontWeight(.bold)
                                                    .font(.system(size: 10)).multilineTextAlignment(.center)
                                            }.frame(width: UIScreen.main.bounds.width/8.0)
    //
                                            HStack{
                                                Text(i.TEAM)
                                                    .fontWeight(.bold)
                                                    .font(.system(size: 10)).multilineTextAlignment(.center)
                                            }.frame(width: UIScreen.main.bounds.width/8.0)
                                            
                                            HStack{
                                                Text(i.ACTIVATION_MATURE_MONTH)
                                                    .fontWeight(.bold)
                                                    .font(.system(size: 10)).multilineTextAlignment(.center)
                                            }.frame(width: UIScreen.main.bounds.width/7.0)
                                            Spacer()
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
                        for i in 20...50 {
                            self.YearList.append(YearInfo.init(YEAR_ID: i, YEAR_NAME: "20"+String(i)) )
                        }
                        
                        let inputFormatter = DateFormatter()
                        inputFormatter.dateFormat = "yy"
                        let year = inputFormatter.string(from: self.today)
                        self.YearID=Int(year) ?? 20
                        
                        inputFormatter.dateFormat = "yyyy"
                        self.YearName = inputFormatter.string(from: self.today)
                        
                        inputFormatter.dateFormat = "MMM"
                        self.MonthName = inputFormatter.string(from: self.today)
                        
                    })
                    
                }
            }
             
            
        }
        
    }
    
    
}

//Afzal
