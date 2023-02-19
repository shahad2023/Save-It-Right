//
//  EmptyCategory.swift
//  Save_It_Right
//
//  Created by Shahad BaMakhshab on 06/02/2023.
//

import SwiftUI

struct Categories: View {
    
    let pageTitle:String
    
    init(pageTitle:String){
        self.pageTitle = pageTitle
        UISegmentedControl.appearance().selectedSegmentTintColor = .tintColor
    }
    
    @State private var activeExpired = "Active"
    @State private var searchText = ""
    @State private var date = Date()
    @State private var showWarrantyPage = false
    
    var body: some View {
        
//        NavigationView{
            ZStack{
            
                VStack{
                    Text( "\(searchText)")
                        .searchable(text: $searchText)
                    
                    Picker("", selection: $activeExpired) {
                        Text("Active").tag("Active")
                        Text("Expired").tag("Expired")
                            }
                            .pickerStyle(.segmented)
                            .padding()
                            Spacer()
                    
                        }.navigationTitle(pageTitle)
                         .toolbar{
                        ToolbarItem{
                            NavigationLink("Edit", destination: WarrantyPage(selectedCateg: Binding<Catg?>.constant(nil)) )
                                    }
                                 }
                
                VStack{
                    Image("Bird")
                    Text("There are no items to display.")
                        .foregroundColor(Color.white)
                        .font(.title2)
                    
                    
                    Button(action: { showWarrantyPage = true }){
                        Text("Add warranty")
                    }
                    .frame(width: 167.0, height: 50.0)
                    .background(Color("Blue2"))
                    .foregroundColor(.white)
                    .cornerRadius(6)
                    .font(.system(size: 20))
                    }
             
            }
        }
    }
//}

struct Categories_Previews: PreviewProvider {
    static var previews: some View {
        Categories(pageTitle: "Testing")
            .preferredColorScheme(.dark)
    }
}



//Import SwiftUI

//struct Empty_Category: View {
//// @State var pickedTheme = "1"
//init(){
//UISegmentedControl.appearance().backgroundColor = .darkText
//UISegmentedControl.appearance().selectedSegmentTintColor = .systemBlue
//UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(Color.white)], for: .selected)
//UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(Color.white)], for: .normal)
//}
//@State private var activeExpired = "Active"
//@State private var searchText = ""
//@State private var date = Date()
//
//var body: some View {
//
//    NavigationView{
//        ZStack{
//            Color.black
//            .edgesIgnoringSafeArea(.all)
//        VStack{
//
//        Text( "\(searchText)")
//
//        .searchable(text: $searchText)
//        Picker("", selection: $activeExpired) {
//        Text("Active").tag("Active")
//        Text("Expired").tag("Expired")
//                }
//        .pickerStyle(.segmented)
//        .padding()
//        Spacer()
//
//
//
//
//
//            }.navigationTitle("Jewelery")
//                .toolbar{
//                    ToolbarItem{
//                        NavigationLink("Edit", destination: OnBoarding() )
//
//                    }
//                }
//            VStack{
//                Image("bird")
//                Text("There are no items to display.")
//                    .foregroundColor(Color.white)
//                    .font(.title2)
//
//
//                Button("Add warranty"){
//
//                }
//
//                .frame(width: 167.0, height: 50.0)
//                .background(Color.blue)
//
//                .foregroundColor(.white)
//                .cornerRadius(6)
//                .font(.system(size: 20))
//            }
//        }
//    }
//
//       }
//            }
//struct Empty_Category_Previews: PreviewProvider {
//static var previews: some View {
//Empty_Category()
//.preferredColorScheme(.dark)
//}
//}
