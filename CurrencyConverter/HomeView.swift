//
//  HomeView.swift
//  Covid iOS Tracker
//
//  Created by Admin on 10/11/20.
//

import SwiftUI
import Combine

struct HomeView: View {
    @ObservedObject var data = getData()
    @State var uru : String = "0"
    @State var usd : String = "0"
    @State var convertido : Double = 0.00
    
    var body: some View {
        VStack{
            
            VStack(spacing: 10) {
                Image("imagen").resizable().frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxWidth: 200, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealHeight: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxHeight: 180, alignment: .top)
                Text("Convertidor de monedas:").bold().padding()
                
                HStack{
                    
                    Label(
                        title: { Text("USD") },
                        icon: { Image(systemName: "repeat.circle") }
                    )
                    
                    TextField("Numero", text: $usd)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .ignoresSafeArea(.keyboard, edges: .bottom)
                        .keyboardType(.default)
                        .textContentType(.creditCardNumber)
                        .onChange(of: usd, perform: { value in
                            if (value != ""){
                                self.convertido = Double(self.usd)! * self.data.data.rates.USD.buy
                            }
                        }).onTapGesture {
                            self.uru = "0"
                            self.usd = ""
                            
                        }
                }.padding()
                
                HStack{
                    Label(
                        title: { Text("UYU") },
                        icon: { Image(systemName: "repeat.circle.fill") }
                    )
                    
                    TextField("Numero", text: $uru)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .ignoresSafeArea(.keyboard, edges: .bottom)
                        .keyboardType(.numberPad)
                        .textContentType(.creditCardNumber)
                        .onChange(of: uru, perform: { value in
                            if (value != ""){
                                self.convertido = Double(self.uru)! / self.data.data.rates.USD.sell
                            }
                        }).onTapGesture {
                            self.usd = "0"
                            self.uru = ""
                        }
                }.padding()
                
                
                
                VStack{
                    Text("Valor convertido:")
                    Text(getValue(data: self.convertido))
                }.padding()
                
                
                
            }.padding()
            
            
        }
    }
    
    func getValue(data: Double) -> String{
        let format = NumberFormatter()
        format.numberStyle = .decimal
        return format.string(for: data)!
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
