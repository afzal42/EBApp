//
//  KPIDashboardUIView.swift
//  EBApp
//
//  Created by Md. Afzal Hossain on 9/6/21.
//

import Charts
import SwiftUI

struct KPIDashboardUIView: View {
    @Binding var index: Int
    @Binding var lastPageIdx: Int
    @Binding var lastPageArray: [Int]
    @Binding var title: String
    
    @State var tableHeader = ["KPI Parameter","Indicator","Target","Achivement","Achivement%","Growth%"]
    
    @State var OptionId: Int=0
//    @State private var allTransactions:[Transaction] = [
//        .init(xValue: 100, yValue: 200, itemType: Transaction.ItemType.itemAch),
//        .init(xValue: 33, yValue: 4, itemType: Transaction.ItemType.itemAch),
//            .init(xValue: 12, yValue: 145, itemType: Transaction.ItemType.itemAch),
//            .init(xValue: 45, yValue: 103, itemType: Transaction.ItemType.itemAch),
//            .init(xValue: 35, yValue: 200, itemType: Transaction.ItemType.itemAch),
//            .init(xValue: 79, yValue: 45, itemType: Transaction.ItemType.itemAch)
//    ]
    
    var body: some View {
        ZStack{
            VStack{
                HStack{
                    Button(action: {
                        self.OptionId=0
                    }, label: {
                        
                        VStack(spacing: 5){
                            
                            Image(self.OptionId == 0 ? "radio.fill" : "radio").foregroundColor(.yellow)
                                .frame(width:100)
                            Text("Table").foregroundColor(Color("IconColor")).font(.system(size: 14))
                        }
                    })
                    Spacer(minLength: 0)
                    Button(action: {
                        self.OptionId=1
                    }, label: {
                        VStack(spacing: 5){
                            Image(self.OptionId == 1 ? "radio.fill" : "radio").foregroundColor(.yellow)
                                .frame(width:100)
                            Text("Bar Graph").foregroundColor(Color("IconColor")).font(.system(size: 14))
                        }
                    })
                    Spacer(minLength: 0)
                    Button(action: {
                        self.OptionId=2
                        
                    }, label: {
                        VStack(spacing: 5){
                            Image(self.OptionId == 2 ? "radio.fill" : "radio").foregroundColor(.yellow)
                                .frame(width:100)
                            Text("Line Graph").foregroundColor(Color("IconColor")).font(.system(size: 14))
                        }
                    })
                }
                .padding(.leading, 10)
                .padding(.trailing, 10)
                .padding(.top, 10)
                .overlay(
                    Rectangle().frame(height: 1.0, alignment: .bottom).padding(.top, -11).background(Color.yellow)
                        .foregroundColor(.yellow)
                        .padding(.leading, 65)
                        .padding(.trailing, 65)
                        .padding(.top, 10)
                )
                VStack{
                    if self.OptionId==0 {
                        
                        HStack{
                            
                            Spacer(minLength: 1)
                            ForEach(self.tableHeader, id:\.self){i in
                                HStack{
                                    Text(i)
                                        .fontWeight(.bold)
                                        .font(.system(size: 8)).multilineTextAlignment(.center)
                                        .padding(.leading,2)
                                }.frame(width: UIScreen.main.bounds.width/7.1)
                                
                                Spacer(minLength: 1)
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
                                
                                ForEach(self.KpiInfoList, id:\.SL){i in
                                    HStack{
                                        HStack{
                                            Text(i.KPI_NAME)
                                                .fontWeight(.bold)
                                                .font(.system(size: 8)).multilineTextAlignment(.leading)
                                                .padding(.leading, 0)
                                            Spacer(minLength: 0)
                                        }.frame(width: UIScreen.main.bounds.width/6.1)
                                        .padding(.leading, 2)
//
                                        HStack{
                                            Image(i.INDICATOR < 4 ? (i.INDICATOR<3 ? "checkmark.circle.fill" : "checkmark.circle.fill.light"):"exclamationmark.circle.fill")
                                                //.foregroundColor(i.ImgVal > 0 ? Color.green.opacity(i.ImgVal == 1 ? 1 : 0.5) : Color.yellow)

//                                            Text(String(i.INDICATOR))
//                                                .fontWeight(.bold)
//                                                .font(.system(size: 8)).multilineTextAlignment(.center)
                                        }.frame(width: UIScreen.main.bounds.width/7.5)
//
                                        HStack{
                                            Text(String(i.TARGET))
                                                .fontWeight(.bold)
                                                .font(.system(size: 8)).multilineTextAlignment(.center)
                                        }.frame(width: UIScreen.main.bounds.width/7.2)

                                        HStack{
                                            Text(String(i.ACHIEVEMENT))
                                                .fontWeight(.bold)
                                                .font(.system(size: 8)).multilineTextAlignment(.center)
                                        }.frame(width: UIScreen.main.bounds.width/7.2)
//
                                        HStack{
                                            Text(String(i.ACHIEVEMENT_PERCENTAGE))
                                                .fontWeight(.bold)
                                                .font(.system(size: 8)).multilineTextAlignment(.center)
                                        }.frame(width: UIScreen.main.bounds.width/7.2)
//
                                        HStack{
                                            Text(String(i.GROWTH_PERCENTAGE))
                                                .fontWeight(.bold)
                                                .font(.system(size: 8)).multilineTextAlignment(.center)
                                        }.frame(width: UIScreen.main.bounds.width/7.2)
                                        Spacer(minLength: 0)
                                    }
                                    .padding(.top,5)
                                    .padding(.bottom,5)
                                    .background(Color("IconColor").opacity(i.SL % 2 == 0 ? 0.1 : 0))
                                }
                            }
                        }
                        .padding(1)
                        .padding(.leading,2)
                        .padding(.trailing,2)
                        
                        
                    }
                    else if self.OptionId==1{
                        BarChart(entries: self.barData, BarXString:self.BarXString)
//                            .frame(height: UIScreen.main.bounds.height * 0.5)
                            .padding(.horizontal)
                    }
                    else if self.OptionId==2{
                        
                        LineChart(
                            entriesAch: self.lineData,LineXString:self.BarXString
                        )
                        .padding(.horizontal)
                    }
                }
                .padding(10)
                .padding(.top,10)
                
                Spacer()
            }
            .onAppear(perform: {
                funKpiInfo()
            })
            
        }
    }
    
    @State var KpiInfoList = [KpiInfo]()
    @State var barData=[BarChartDataEntry]()
    @State var BarXString = [String]()
    
    @State var lineData=[ChartDataEntry]()
    
    func funKpiInfo() {
        guard let url = URL(string: baseUrl+"/api/EB_AMS_User/Get_User_KPI_Dashboard") else { return }
        
        let defaults = UserDefaults.standard
        
        let Login_Name = defaults.string(forKey: defaultsKeys.Login_Name)!
        let Access_Key = defaults.string(forKey: defaultsKeys.Access_Key)!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let postString = "{'USER_NAME':'\(Login_Name)','ACCESS_KEY':'\(Access_Key)'}";
        // Set HTTP Request Body
        request.httpBody = postString.data(using: String.Encoding.utf8);
        
        self.KpiInfoList.removeAll()
        self.BarXString.removeAll()
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                return
            }
            if let dataString = String(data: data, encoding: .utf8) {
//                print("Response data string:\n \(dataString)")
                let decoder = JSONDecoder()

                do {
                    let resData = try decoder.decode([KpiInfoX].self, from: data)
//                    print(resData)
                    for i in 0...resData.count-1 {
                        
                        let obj = resData[i]
                        self.KpiInfoList.append(KpiInfo.init(SL: i+1, KPI_NAME: obj.KPI_NAME, INDICATOR: obj.INDICATOR, TARGET: obj.TARGET, ACHIEVEMENT: obj.ACHIEVEMENT, ACHIEVEMENT_PERCENTAGE: obj.ACHIEVEMENT_PERCENTAGE, GROWTH_PERCENTAGE: obj.GROWTH_PERCENTAGE))
                        
                        self.barData.append(BarChartDataEntry(x: Double(i), y: resData[i].GROWTH_PERCENTAGE))
                        self.lineData.append(ChartDataEntry(x: Double(i), y: resData[i].GROWTH_PERCENTAGE))
                        BarXString.append(resData[i].KPI_NAME)
                    }
                } catch {
                    print(error.localizedDescription)
                }
                
            }
        }
        .resume()
    }
}
