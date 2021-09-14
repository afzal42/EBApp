//
//  ContentView.swift
//  EBApp
//
//  Created by Md. Afzal Hossain on 8/26/21.
//

import SwiftUI



struct ToggleModel {
    var isWifiOpen: Bool = true {
        willSet {
            if self.isWifiOpen == false {
                print("Dark Mode")
                let defaults = UserDefaults.standard
                defaults.set("1", forKey: defaultsKeys.isDark)
            }
            else{
                print("Light Mode")
                let defaults = UserDefaults.standard
                defaults.set("0", forKey: defaultsKeys.isDark)
            }
        }
    }
}

struct ContentView: View {
    @ObservedObject var locationManager = LocationManager()

    @State var isDark: Bool = false
    @State var isLoad: Bool = false
    @State var index: Int=0
    @State var title: String="Home"
    @State var lastPageArray: [Int]=[0]
    @State var lastPageIdx: Int=0
    @State var Kpikey: String=""

    @State var height: CGFloat = UIScreen.main.bounds.height/5
    @State var selectedIndex = 0
    @State private var kpiIndex = 0
    @State var width = UIScreen.main.bounds.width - 120
    @State var qaValue: CGFloat = (UIScreen.main.bounds.height > 700 ? 50: 40)
    
    @State var lat: Double = 0.0
    @State var long: Double = 0.0

    var body: some View {

        ZStack{
            Color("bgColor")
//            VStack{
//                if let location = locationManager.lastLocation {
//                    Text("Your location: \(location.coordinate.latitude), \(location.coordinate.longitude)")
//                }
//
//                Button(action: {
//                    locationManager.getCurrentLocation()
//                }, label: {
//                    Text("Location")
//                })
//                .frame(height: 44)
//                .padding()
//            }
            Home(isDark:$isDark, lastLatitude: $lat,lastLongitude:$long).background(Color("bgColor")).colorScheme(isDark ? .dark: .light)
                .onAppear(perform: {
                    if let location = locationManager.lastLocation {
                    self.lat = location.coordinate.latitude
                    self.long = location.coordinate.longitude
                    }
                })
        }
        .background(Color("bgColor"))
        .onAppear {
            AppUpdater.shared.showUpdate(withConfirmation: false)
            let defaults = UserDefaults.standard
            if let check: String = defaults.string(forKey: defaultsKeys.isDark){
                let mode: String = defaults.string(forKey: defaultsKeys.isDark)!
                if mode == "1" {
                    self.isDark = true
                }
                else
                {
                    self.isDark = false
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



struct Home : View {
    
    @Binding var isDark: Bool
    @Binding var lastLatitude : Double
    @Binding var lastLongitude : Double
    
    @State var width = UIScreen.main.bounds.width - 90
    // to hide view...
    @State var x = UIScreen.main.bounds.width + 90
    @State var index: Int = 0
    @State var title: String = "Home"
    @State var isLogin: Bool = true
    @State var isOTP: Bool = false
    @State var lastPageIdx: Int = 0
    @State var lastPageArray: [Int] = [
        0
    ]
    @State var Kpikey: String = "1"
    
    
    @ObservedObject var locationManager = LocationManager()
    
    var body: some View{
        VStack{
            ZStack(alignment: .topLeading) {
            
                if isLogin {
                    
                    LoginUIView(isLogin: $isLogin)
                    .background(Color("bgColor"))
                    .edgesIgnoringSafeArea(.all)
                    //bg=121422 bar=1C1C1E
                    Spacer()
                }
                else
                {
                    HomePage(isDark:$isDark, x: $x, index: $index, title: $title, lastPageIdx: $lastPageIdx, lastPageArray: $lastPageArray, isLogin: $isLogin, lastLatitude: $lastLatitude, lastLongitude: $lastLongitude).background(Color("bgColor"))
                        .onAppear(perform: {
                            
                            if let location = locationManager.lastLocation {
                            self.lastLatitude = location.coordinate.latitude
                            self.lastLongitude = location.coordinate.longitude
                            }
                        })
                        
                    
                }
            }
            .onAppear(perform: {
                
                let defaults = UserDefaults.standard
                if let name: String = defaults.string(forKey: defaultsKeys.User_Name){
                    if let key = defaults.string(forKey: defaultsKeys.Access_Key){
                        self.isLogin=false
                    }
                    else{
                        self.isLogin=true
                    }
                }
                else{
                    self.isLogin=true
                }
            })
        }
        .background(Color("bgColor"))
        
    }
}



struct HomePage : View {
    
    @Binding var isDark: Bool
    @Binding var x : CGFloat
    @State var expand = false
    
    @State var height = UIScreen.main.bounds.size.height
    @State var xheight: CGFloat = UIScreen.main.bounds.height
    
    @State var show = false
    @State var txt : String = ""
    
    @Binding var index: Int
    @Binding var title: String
    @Binding var lastPageIdx: Int
    
    @Binding var lastPageArray: [Int]
    
    @Binding var isLogin: Bool
    @Binding var lastLatitude : Double
    @Binding var lastLongitude : Double
    
    @State var streetLocation:String=""
    @State var searchAddress:String=""
    @State var isFocused:Bool=true
    @State var requestSearch:Bool=true
    
    @State var isToast: Bool = false
    @State var msg: String = ""
    
    @ObservedObject var locationManager = LocationManager()
    
    var body : some View{
            
        VStack(spacing: 0){
            
            VStack{
                HStack{
                    if self.index > 0 {
                        Button(action: {
                            self.index=0
                            self.title="Home"
                        }, label: {
                            Image(systemName: "chevron.left")
                                .renderingMode(.template)
                                .foregroundColor(Color("IconColor"))
                                .padding(.trailing, 10)
                        })
                    }
                    Text(self.title)
                        .fontWeight(.bold)
                        .font(.system(size: 20))
                        .padding(.leading, self.index>0 ? 0:5)
                        .foregroundColor(Color("IconColor"))
                    Spacer()
                    
//                    Button(action: {
//                        self.isDark.toggle()
//                    }, label: {
//                        Image(systemName: "radio")
//                            .foregroundColor(Color("IconColor"))
//                            .padding(.leading, 5)
//                            .padding(.trailing, 10)
//                    })
                    
                    if self.index == 0 {
                        Button(action: {
                            withAnimation {
                                if let url = URL(string: "https://www.google.com") {
                                       UIApplication.shared.open(url)
                                   }
                            }
                        }, label: {
                            Image(systemName: "magnifyingglass").foregroundColor(Color("IconColor")).padding(10)
                        })
                        
                        Button(action: {
                            self.isLogin.toggle()
                        }, label: {
                            Image("sign_out")
                                .foregroundColor(Color("IconColor"))
                                .padding(.leading, 5)
                                .padding(.trailing, 10)
                        })
                    }
                }
                .padding(.leading, 5)
            }
            .frame(height: 40)
            Divider()
            VStack{
                
                switch self.index {
                    case 0:
                        HomeUIView(isLogin: $isLogin, index: $index, title: $title, lastPageIdx: $lastPageIdx, lastPageArray: $lastPageArray, lastLatitude:self.lastLatitude, lastLongitude:self.lastLongitude)
                            
                    case 1:
                        CheckInUIView(index: $index, title: $title, lastPageIdx: $lastPageIdx, lastPageArray: $lastPageArray, lastLatitude:self.lastLatitude, lastLongitude:self.lastLongitude)
                            .padding(.top,1)
                    case 2:
                        CheckOutUIView(index: $index, title: $title, lastPageIdx: $lastPageIdx, lastPageArray: $lastPageArray, lastLatitude:self.lastLatitude, lastLongitude:self.lastLongitude)
                    case 3:
                        VisitReportUIView(index: $index, lastPageIdx: $lastPageIdx, lastPageArray: $lastPageArray, title: $title).padding(.top,1)
                    case 4:
                        SalesUpdateUIView(index: $index, lastPageIdx: $lastPageIdx, lastPageArray: $lastPageArray, title: $title).padding(.top,1)
                    case 5:
                        KPIDashboardUIView(index: $index, lastPageIdx: $lastPageIdx, lastPageArray: $lastPageArray, title: $title)
                    case 6:
                        GiftInventoryStockUIView(index: $index, lastPageIdx: $lastPageIdx, lastPageArray: $lastPageArray, title: $title).padding(.top,1)
                    default:
                        Text("Under Development")
                        Spacer()
                }
            }
            
        }
//        .background(Color.primary.opacity(0.1))
//        .edgesIgnoringSafeArea(.all)
    }
}


//Afzal Hossain
