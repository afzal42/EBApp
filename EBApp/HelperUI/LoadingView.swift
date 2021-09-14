//
//  LoadingView.swift
//  EBApp
//
//  Created by Md. Afzal Hossain on 8/28/21.
//

import SwiftUI

struct LoadingUIView: View {
    @State var isLoad: Bool = false
    var body: some View {
        ZStack{
        LoadingView(isShowing: $isLoad){
            HStack{
                
            }
        }
        HStack{
            Text("Afzal Hossain")
            Button(action: {
                isLoad.toggle()
            }, label: {
                /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
            })
        }
        }
    }
}

struct LoadingUIView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingUIView()
    }
}

struct LoadingView<Content>: View where Content: View {

    @Binding var isShowing: Bool
    var content: () -> Content

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {

                self.content()
                    .disabled(self.isShowing)
                    .blur(radius: self.isShowing ? 3 : 0)

                VStack {
                    HStack{
                        
                        ActivityIndicator(isAnimating: .constant(true), style: .large)
                            .background(Color.white)
                            .foregroundColor(Color.black)
                            .padding(.leading, 20)
                        
                        Text("Please Wait.....")
                            .foregroundColor(Color.black).padding(.leading, 20)
                        Spacer()
                    }
                }
                .frame(width: geometry.size.width-120,
                       height: 60, alignment: .center)
                .background(Color.white)
                .foregroundColor(Color.black)
                .cornerRadius(20)
                .padding(10)
                .shadow(radius: 20)
                .opacity(self.isShowing ? 1 : 0)

            }
        }
    }

}



struct ToastView<Content>: View where Content: View {

    @Binding var isShowing: Bool
    @Binding var message: String
    var content: () -> Content

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {

                self.content()
                    .disabled(self.isShowing)
                    .blur(radius: self.isShowing ? 3 : 0)

                VStack {
                    HStack{
                        Text(message).foregroundColor(Color.black).padding(.leading, 20)
                        Spacer()
                    }
                }
                .frame(width: geometry.size.width-20,
                       height: 60, alignment: .center)
                .background(Color.white)
                .foregroundColor(Color.black)
                .cornerRadius(20)
                .padding(10)
                .shadow(radius: 20)
                .opacity(self.isShowing ? 1 : 0)
            }
        }
        
    }
    
}



struct ActivityIndicator: UIViewRepresentable {

    @Binding var isAnimating: Bool
    let style: UIActivityIndicatorView.Style

    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}

//Afzal Hossain
