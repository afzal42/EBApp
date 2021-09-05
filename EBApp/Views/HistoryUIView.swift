//
//  HistoryUIView.swift
//  EBApp
//
//  Created by Md. Afzal Hossain on 8/28/21.
//


import SwiftUI

struct HistoryUIView: View {
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
    
    func funVisitHistory() {
        guard let url = URL(string: baseUrl+"/api/EB_AMS_User/Get_CheckIn_CheckOut_History") else { return }
        
        let defaults = UserDefaults.standard
        
        let Login_Name = defaults.string(forKey: defaultsKeys.Login_Name)!
        let Access_Key = defaults.string(forKey: defaultsKeys.Access_Key)!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let postString = "{'USER_NAME':'\(Login_Name)','ACCESS_KEY':'\(Access_Key)','START_DATE': '\(self.fromDate)','END_DATE': '\(self.toDate)'}";
        // Set HTTP Request Body
        request.httpBody = postString.data(using: String.Encoding.utf8);
        
        CheckInList.removeAll()
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                return
            }
            if let dataString = String(data: data, encoding: .utf8) {
                print("Response data string:\n \(dataString)")
                let decoder = JSONDecoder()

                do {
                    let resData = try decoder.decode([CheckinInfo].self, from: data)
                    if dataString != "[]"{
                    print(resData)
                    for i in 0...resData.count-1 {
                        CheckInList.append(resData[i])
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
                        VStack{
                            HStack{
                                HStack{
                                    Text("From:").foregroundColor(Color.gray)
                                    Text("\(dtFromDate, formatter: Self.taskDateFormat)")
                                        .fontWeight(.bold)
                                    .onTapGesture(perform: {
                                        dtFrmX = 0
                                    })
                                    Image(systemName: "calendar").frame(width: 10, height: 10)
                                }
                                Spacer(minLength: 0)
                                HStack{
                                    Text("To:").foregroundColor(Color.gray)
                                    Text("\(dtToDate, formatter: Self.taskDateFormat)")
                                        .fontWeight(.bold)
                                    .onTapGesture(perform: {
                                        dtToX = 0
                                    })
                                    Image(systemName: "calendar").frame(width: 10, height: 10)
                                }
                                
                            }
                            .padding(5)
                        
                            HStack{
                                Spacer(minLength: 0)
                                Button(action: {
                                    self.funVisitHistory()
                                }, label: {
                                    Text("Search")
                                    .fontWeight(.bold)
                                    .frame(width: 65, height: 25)
                                    .padding(.leading,10).padding(.trailing,10)
                                    .padding(5)
                                    .foregroundColor(Color.white)
                                })
                                .background(Color("btnColor"))
                                .cornerRadius(3)
                            }
                        }
                        .padding(10)
                        
                        
                        HStack{
                            HStack{
                            Image("disclaimer2").foregroundColor(Color.red)
                            }
                            Spacer()
                            HStack{
                                Image("calendar")
                                Text("\(dueDate!, formatter: Self.taskDateFormat)")
                                    .font(.system(size: 12))
                            }
                            .padding(.trailing, 10)
                            .padding(.bottom, 5)
                        }
                        .background(Color("IconColor").opacity(0.2))
                        .overlay(
                            RoundedRectangle(cornerRadius: 0)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                        
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
                        .padding(.top, 10)
                        .padding(.bottom, 10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 0)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                        VStack{
                            
                            ScrollView(.vertical, showsIndicators: false) {
                                
//                                ForEach(CheckInList, id:\.self){i in
//                                    HStack{
//                                        HStack{
//                                            Text(i.COMPANY_NAME)
//                                                .fontWeight(.bold)
//                                                .font(.system(size: 10)).multilineTextAlignment(.leading)
//                                            Spacer(minLength: 0)
//                                        }.frame(width: UIScreen.main.bounds.width/5.2)
//                                        .padding(.leading, 5)
//
//                                        HStack{
//                                            Text(i.COMPANY_TYPE)
//                                                .fontWeight(.bold)
//                                                .font(.system(size: 10)).multilineTextAlignment(.center)
//                                        }.frame(width: UIScreen.main.bounds.width/5.5)
//
//                                        HStack{
//                                            Text(i.CHECK_IN_DATE)
//                                                .fontWeight(.bold)
//                                                .font(.system(size: 10)).multilineTextAlignment(.center)
//                                        }.frame(width: UIScreen.main.bounds.width/5.5)
//
//                                        HStack{
//                                            Text(i.CHECK_OUT_DATE)
//                                                .fontWeight(.bold)
//                                                .font(.system(size: 10)).multilineTextAlignment(.center)
//                                        }.frame(width: UIScreen.main.bounds.width/5.5)
//
//                                        HStack{
//                                            Text(i.VISIT_PURPOSE)
//                                                .fontWeight(.bold)
//                                                .font(.system(size: 10)).multilineTextAlignment(.center)
//                                        }.frame(width: UIScreen.main.bounds.width/5.5)
//                                        Spacer()
//                                    }
//                                    .padding(.top,5)
//                                    .padding(.bottom,5)
//                                    .background(Color("IconColor").opacity(i.SL % 2 == 0 ? 0.1 : 0))
//                                }
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
