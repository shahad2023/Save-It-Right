
//
//  AddWarranty.swift
//  Save_It_Right
//
//  Created by Shouq Turki Bin Tuwaym on 09/02/2023.
//

import SwiftUI
import Combine


struct WarrantyItemComponenet: View {
    //    @State var isOn = false
    @State
    var value:Warranty
    
    @Binding
    var parentCategory: Catg
    
    @State
    var isLinkActive = false
    var startDate = Date()
    @Environment(\.managedObjectContext) var moc
    
    
    var body: some View{
        Button(action:{self.isLinkActive = true}, label:{
            VStack(alignment: .leading, spacing: 0){
                Text($value.deviceName.wrappedValue)
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.bottom, 10)
                HStack(spacing: 0) {
                    VStack(alignment: .leading, spacing: 0){
                        
                        
                        Text("Start Date:")
                            .fontWeight(.medium)
                            .padding(0)
                        Text(getDate($value.startDate.wrappedValue))
                            .padding(.bottom, 10)
                        
                        Text("End Date:")
                            .fontWeight(.medium)
                            .padding(0)
                        Text(getDate($value.expirationDate.wrappedValue))
                            .padding(.bottom, 10)
                        
                        
                        Text("Duration:")
                            .fontWeight(.medium)
                            .padding(0)
                        HStack(spacing:10){
                            if $value.durationYears.wrappedValue > 0{
                                Text(
                                    String( $value.durationYears.wrappedValue) + "  " + (LocalizedStringKey("Years").stringValue() ?? "Years")
                                )
                                .font(.footnote)
                                .padding(0)
                                
                            }
                            if $value.durationMonths.wrappedValue > 0 {
                                Text(
                                    String($value.durationMonths.wrappedValue) + "  " + (LocalizedStringKey("Months").stringValue() ?? "Months")
                                )
                                .font(.footnote)
                                .padding(0)
                            }
                            if $value.durationDays.wrappedValue > 0 {
                                Text(
                                    String($value.durationDays.wrappedValue) + "  " + (LocalizedStringKey("Days").stringValue() ?? "Days")
                                )
                                .font(.footnote)
                                .padding(0)
                            }
                        }
                    }
                    Spacer()
                    if $value.photo.wrappedValue != nil && UIImage(
                        data: $value.photo.wrappedValue!
                    ) != nil {
                        Image(
                            uiImage:
                                UIImage(
                                    data: $value.photo.wrappedValue!
                                )!
                        )
                        .resizable()
                        .scaledToFit()
                        .padding(0)
                        .frame(
                            width: 150,
                            height: 120
                        )
                    }else{
                        Image("photo")
                            .resizable()
                            .scaledToFit()
                            .padding(0)
                            .frame(
                                width: 150,
                                height: 120
                            )
                    }
                    
                    
                }
            }
            .listRowSeparator(.hidden)
            .listRowInsets(
                EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
            )
            .padding(10)
            .frame(minWidth:0,maxWidth: .infinity, alignment: .leading)
            .background(
                
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(Color(red: 0.11, green: 0.11, blue: 0.123))
            )
            .padding(5)
        })
        .tint(.white)
        .background(
            NavigationLink(
                destination:
                    WarrantyPage(
                        selectedCateg: (
                            value.category == nil ? Binding<Catg?>.constant(nil) : Binding($parentCategory)), warranty:value
                    ).environment(
                        \.managedObjectContext,
                         self.moc
                    ),
                isActive: $isLinkActive) {
                     EmptyView()
                 }
                .hidden()
        )
    }
}



struct SearchText: Equatable {
    
    var query : String = ""
}

struct WarrantiesList: View {
//    internal init(category: Catg) {
//
//                UISegmentedControl.appearance().selectedSegmentTintColor = .tintColor
//    }
    
    @State
    var isLinkActive = false
    
    
    
    @State private var activeExpired = 0
    @State var category:Catg
    
    @State var searchText = ""
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Warranty.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Warranty.expirationDate, ascending: true)])
    var warranties: FetchedResults<Warranty>
//        @State var searchText : SearchText = .init()
    
    var body: some View {
        
        List {
            Section{
                Picker("", selection: $activeExpired) {
                    Text("Active").tag(0)
                    Text("Expired").tag(1)
                }
                .onChange(of: activeExpired) { newValue in
                    warranties.nsPredicate = Warranty.filter(searchText, category.rawValue, newValue == 0)
                }
                .padding(0)
                .listRowSeparator(.hidden)
                .listRowInsets(
                    EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
                )
                .pickerStyle(.segmented)
                .padding()
                
            }
            .background()
            .listRowSeparator(.hidden)
            .listRowInsets(
                EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
            )
            
            if warranties.count == 0{
                Section{
                    VStack{
                        Image("Bird")
                        Text("There are no items to display.")
                            .foregroundColor(Color.white)
                            .font(.title2)
                        
                        Button(action:{self.isLinkActive = true}, label:{
                            Text("Add Warranty")
                                .frame(width: 167.0, height: 50.0)
                                .background(Color("Blue2"))
                                .foregroundColor(.white)
                                .cornerRadius(6)
                                .font(.system(size: 20))
                        })
                    }.frame(width: 370)
                }
                .background()
                .listRowSeparator(.hidden)
                .listRowInsets(
                    EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
                )
            }
            
            Section{
                
                ForEach(warranties, id: \.self) { warranty in
                    WarrantyItemComponenet(value: warranty, parentCategory: $category).environment(
                        \.managedObjectContext,
                         self.moc
                    )
                }
                //delete
                .onDelete{ indexSet in
                    for index in indexSet {
                        do{
                            let context = moc
                            let existingWarrnaty = try context.existingObject(with: warranties[index].objectID)
                            context.delete(existingWarrnaty)
                            Task(priority: .background){
                                try await context.perform{
                                    try context.save()
                                }
                            }
                        }catch{
                            
                        }
                    }
                }
                //                    .deleteDisabled(notEditable)
                //                    if alarms.count == 0 {
                //                        Text("No Alarms exist yet")
                //                        .accessibility(label:Text("No Alarms exist yet"))
                //                    }
                
            }
            .background()
            .listRowSeparator(.hidden)
            .listRowInsets(
                EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
            )
        }
        .refreshable(action: {
            try? moc.setQueryGenerationFrom(.current)
        })
        .onAppear{
            UISegmentedControl.appearance().selectedSegmentTintColor = .tintColor
            warranties.nsPredicate = Warranty.filter("", category.rawValue, activeExpired == 0)
        }
        .searchable(text: $searchText)
        .listStyle(InsetGroupedListStyle())
        .scrollContentBackground(.hidden)
        
                    .onChange(of: searchText) { newValue in
                        warranties.nsPredicate = Warranty.filter(newValue, category.rawValue, activeExpired == 0)
                    }
//                        .toolbar{
//                            NavigationLink("Edit", destination: AddWarranty() )
//                        }
        
        .navigationBarItems(
            trailing:
                NavigationLink(
                    destination: WarrantyPage(
                        addMode:true,
                        selectedCateg: Binding($category),
                        editable:true
                    ).environment(
                        \.managedObjectContext,
                         self.moc
                    )
                    // this was commentted out because the notification manager disrupt the preview
                    //                                .environmentObject(notificationManager)
                ){
                    Image(systemName: "plus").foregroundColor(Color("AccentColor 1")).imageScale(.large)
                }
        )
        
        .background(
            NavigationLink(destination: WarrantyPage(
                addMode:true,
                selectedCateg: Binding($category),
                editable:true
            )
                .environment(
                \.managedObjectContext,
                 self.moc), isActive: $isLinkActive) {
                EmptyView()
            }
            .hidden()
        )
        
        .navigationBarTitle(category.localizedName, displayMode: .large)
    }
}





struct Category_Previews: PreviewProvider {
    static var previews: some View {
        
        NavigationView{
            WarrantiesList(category: .Jeweleries)
                .preferredColorScheme(.dark)
                .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        }
    }
}


