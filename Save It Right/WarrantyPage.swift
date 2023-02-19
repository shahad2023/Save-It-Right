//
//  WarrantyPage.swift
//  Save_It_Right
//
//  Created by Shouq Turki Bin Tuwaym on 09/02/2023.
//

import SwiftUI
import Combine




//    Categories
enum Catg: String, Identifiable, CaseIterable
{
    var id: Self {self}
    case Jeweleries = "Jeweleries"
    case Sports = "Sports Equipments"
    case Electronic = "Electronic Devices"
    case Houseware = "Houseware"
    case Spare = "Spare Parts"
    case Others = "Others"
    
    var localizedName: LocalizedStringKey { LocalizedStringKey(rawValue) }
    
}

struct DynamicTextFiled: View {
    var label:String
    @Binding var text:String
    @Binding var editable:Bool
 
    var body: some View {
        if editable {
            HStack{
                Text(label + ": ")
                    .padding()
                    .font(.headline)
                Spacer()
                TextField(label, text: $text)
                    .multilineTextAlignment(.leading)
                    .padding()
                    .background(Color("Gray1"))
                    .cornerRadius(10)
            }
            .frame(width: 370, height: 80, alignment: .leading)
        } else {
            HStack{
                Text(label + ": ")
                    .padding()
                    .font(.headline)
                Spacer()
                Text(text)
                    .padding()
            }
            .frame(width: 370, height: 50, alignment: .leading)
        }
    }
}

struct DynamicPicker<Selection:Hashable>: View {
    var label:String
    @Binding var selection:Selection
    @Binding var editable:Bool
    var selector: [(String?, Selection)]
 
    var body: some View {
            Picker(label, selection: $selection) {
                Text(!editable ? "" : "Choose").foregroundColor(Color("Blue2")).tag(nil as Selection?)
                ForEach(0..<selector.count){ i in
                    Text(selector[i].0 ?? "").tag(selector[i].1)
                }
            }
            .font(.headline)
            .pickerStyle(.navigationLink)
            .tint(Color(.white))
            .multilineTextAlignment(.leading)
            .padding()
            .frame(width: 370, height: 50, alignment: .leading)
            .background(!editable ? Color(.clear) : Color("Gray1"))
            .cornerRadius(10)
            .disabled(!editable)
            .foregroundColor(.white)
    }
}

struct DurationComponent: View {
    
    @Binding var years:String
    @Binding var months:String
    @Binding var days:String
    @Binding var editable: Bool
 
    var body: some View {
        if editable {
            HStack{
                Text("Years")
                    .padding()
                Spacer()
                Text("Months")
                    .padding()
                Spacer()
                Text("Days")
                    .padding()
            }
            HStack{
                TextField("Years", text: $years)
                    .multilineTextAlignment(.leading)
                    .keyboardType(.numberPad)
                    .padding()
                    .onReceive(Just(years)) { newValue in
                        let filtered = newValue.filter { "0123456789".contains($0) }
                        if filtered != newValue {
                            self.years = filtered
                        }
                    }
                //                                .frame(width: 370, height: 50)
                    .background(Color("Gray1"))
                    .cornerRadius(10)
                TextField("Months", text: $months)
                    .multilineTextAlignment(.leading)
                    .padding()
                    .onReceive(Just(months)) { newValue in
                        let filtered = newValue.filter { "0123456789".contains($0) }
                        if filtered != newValue {
                            self.months = filtered
                        }
                    }
                //                                .frame(width: 370, height: 50)
                    .background(Color("Gray1"))
                    .cornerRadius(10)
                TextField("Days", text: $days)
                    .multilineTextAlignment(.leading)
                    .padding()
                    .onReceive(Just(days)) { newValue in
                        let filtered = newValue.filter { "0123456789".contains($0) }
                        if filtered != newValue {
                            self.days = filtered
                        }
                    }
                //                                .frame(width: 370, height: 50)
                    .background(Color("Gray1"))
                    .cornerRadius(10)
            }
        } else {
            HStack(){
                Text(
                    "Years \n" +
                    (
                        ( (Int(years) ?? 0) == 0 ) ? "-" : years
                    )
                )
                .font(.callout)
                .padding(0)
                .layoutPriority(1)
                .multilineTextAlignment(.center)
                Spacer()
                Text(
                    "Months \n" +
                    (
                        ( (Int(months) ?? 0) == 0 ) ? "-" : months
                    )
                )
                .font(.callout)
                .padding(0)
                .layoutPriority(1)
                .multilineTextAlignment(.center)
                Spacer()
                Text(
                    "Days \n" +
                    (
                        ( (Int(days) ?? 0) == 0 ) ? "-" : days
                    )
                )
                .font(.callout)
                .padding(0)
                .layoutPriority(1)
                .multilineTextAlignment(.center)
            }
            .frame(width: 350, height: 50, alignment: .leading)
            .padding(10)
        }
    }
}
    

//func test(){
//    Catg.allCases.map{$0.localizedName.}
//}

enum RemindmeOption: String, Identifiable, CaseIterable{
    var id: Self {self}
    case OneDay = "One Day"
    case OneWeek = "One Week"
    case TwoWeeks = "Two Weeks"
    case OneMonth = "One Month"
    case TwoMonths = "Two Months"
    case ThreeMonths = "Three Months"
    case SixMonths = "Six Months"
    
    var numberOfDays:Int {
        switch self{
            case .OneDay:
                return 1
            case .OneWeek:
                return 7
            case .TwoWeeks:
                return 14
            case .OneMonth:
                return 30
            case .TwoMonths:
                return 60
            case .ThreeMonths:
                return 90
            case .SixMonths:
                return 180
        }
    }
    
    static func fromRowNumber(_ num:Int32) -> RemindmeOption {
        switch num{
            case 1:
                return .OneDay
            case 7:
                return .OneWeek
            case 14:
                return .TwoWeeks
            case 30:
                return .OneMonth
            case 60:
                return .TwoMonths
            case 90:
                return .ThreeMonths
            case 180:
                return .SixMonths
            default:
                return .OneDay
        }
    }
}

struct WarrantyPage: View {
    
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    //Text field
    @State var deviceName: String = ""
    @State var shopName: String = ""
    @State var companyName: String = ""
    @State var durationDays: String = ""
    @State var durationMonths: String = ""
    @State var durationYears: String = ""
    @State var note: String = ""
    @State var done = false
    
    
    @State private var isShowingPopup = false
    @State private var scale: CGFloat = 1.0
    @State private var position = CGPoint(x: 0, y: 0)
    @State private var currentPosition = CGPoint(x: 0, y: 0)
    @GestureState private var dragOffset = CGSize.zero
    
    var addMode = false
    
    //Select Date
    @State var selectedDate = Date()
    
    //add photo
    @State var changeImage = false
    @State var openCamera = false
    @State var imageSelected = UIImage()
    
    //Remind
    @State  var selectedRemind:RemindmeOption = .OneDay
    
    //selectedCateg
    @Binding var selectedCateg: Catg?
    
    @State var editable = false
    
    @State var warranty:Warranty?
    
    @State var validationError = false
    
    
     func updateState() {
         if self.warranty == nil {
             return
         }
         let warranty = self.warranty!

        if warranty.photo != nil && UIImage(
            data: warranty.photo!
        ) != nil {
            self.imageSelected = UIImage(
                        data: warranty.photo!
                    )!
            changeImage = self.imageSelected.size.width != 0
        }

        self.deviceName = warranty.deviceName
        self.shopName = warranty.shopName ?? ""
        self.companyName = warranty.companyName
        self.selectedCateg = Catg(rawValue: warranty.category ?? "")

        self.durationDays = String(warranty.durationDays)
        self.durationMonths = String(warranty.durationMonths)
        self.durationYears = String(warranty.durationYears)

        self.selectedDate = warranty.startDate
        self.selectedRemind  = RemindmeOption.fromRowNumber(warranty.remainderBeforeDays)
         self.note = warranty.note ?? ""
//
//        do {
//            try self.moc.save()
//            self.presentationMode.wrappedValue.dismiss()
//        } catch {
//            print("whoops \(error.localizedDescription)")
//        }
    }
    
    func addUpdateWarranty() {
        let warranty = self.warranty == nil ? Warranty(context: self.moc) : self.warranty!
        
        
        warranty.photo = self.imageSelected.pngData()
        warranty.deviceName = self.deviceName
        warranty.shopName = self.shopName
        warranty.companyName = self.companyName
        warranty.category = self.selectedCateg == nil ? nil : self.selectedCateg?.rawValue
        
        warranty.durationDays = Int32(self.durationDays == "" ? "0" : self.durationDays)!
        warranty.durationMonths = Int32(self.durationMonths == "" ? "0" : self.durationMonths)!
        warranty.durationYears = Int32(self.durationYears == "" ? "0" : self.durationYears)!
        
        warranty.startDate = self.selectedDate
        warranty.remainderBeforeDays = Int32(self.selectedRemind.numberOfDays)
        warranty.note = self.note

        do {
            try self.moc.save()
            self.presentationMode.wrappedValue.dismiss()
        } catch {
            print("whoops \(error.localizedDescription)")
        }
    }
    
    func storeCurrentState(){
        let warranty = self.warranty == nil ? Warranty(context: self.moc) : self.warranty!
        
        warranty.photo = self.imageSelected.pngData()
        warranty.deviceName = self.deviceName
        warranty.shopName = self.shopName
        warranty.companyName = self.companyName
        warranty.category = self.selectedCateg == nil ? nil : self.selectedCateg?.rawValue
        
        warranty.durationDays = Int32(self.durationDays == "" ? "0" : self.durationDays)!
        warranty.durationMonths = Int32(self.durationMonths == "" ? "0" : self.durationMonths)!
        warranty.durationYears = Int32(self.durationYears == "" ? "0" : self.durationYears)!
        
        warranty.startDate = self.selectedDate
        warranty.remainderBeforeDays = Int32(self.selectedRemind.numberOfDays)
        warranty.note = self.note
        
        self.warranty = warranty
    }
    
    func validate() -> Bool{
        if (self.deviceName == "" || self.selectedCateg == nil) {
            validationError = true
            return false
        }
        return true
    }
    
    var body: some View {
        let dragGesture = DragGesture()
            .updating($dragOffset) { value, state, _ in
                state = value.translation
            }
            .onEnded { value in
                self.position.x += value.translation.width
                self.position.y += value.translation.height
                self.currentPosition = self.position
            }
        
        let magnificationGesture = MagnificationGesture()
            .onChanged { value in
                self.scale = value
            }
            .onEnded { value in
                self.scale = value
            }
        
            VStack(alignment: .leading){
                ScrollView(){
                    
                    if editable {
                        Button(action: {
                            openCamera = true
                        }, label: {
                            ZStack{
                                Rectangle()
                                    .foregroundColor(Color("Gray1"))
                                    .frame(width: 370, height: 160)
                                Image(uiImage: imageSelected)
                                    .resizable()
                                    .frame(width: 360,height: 160)
                                    .padding(0)
                                if !changeImage{
                                    
                                    Text("Add photo +")
                                        .font(.system(size: 20).bold())
                                }
                            }
                        })
                        .sheet(isPresented: $openCamera, onDismiss: {
                            changeImage = imageSelected.size.width != 0
                        }){
                            ImagePicker(selectedImage: $imageSelected, sourceType: .photoLibrary)
                        }
                        if imageSelected.size.width != 0{
                            Button(action:{
                                imageSelected = UIImage()
                                changeImage = false
                            }, label: {
                                Text("Remove Photo")
                                    .fontWeight(.medium)
                                    .foregroundColor(.red)
                                    .padding(/*@START_MENU_TOKEN@*/.leading, 250.0/*@END_MENU_TOKEN@*/)
                            })
                        }
                    } else {
                    
                        Button(action: {
                            self.isShowingPopup = true
                        }) {
                            ZStack{
                                Rectangle()
                                    .foregroundColor(Color("Gray1"))
                                    .frame(width: 370, height: 160)
                                Image(uiImage: imageSelected)
                                    .resizable()
                                    .frame(width: 360,height: 160)
                                    .padding(0)
                            }
                        }
                        .sheet(isPresented: $isShowingPopup) {
                            Image(uiImage: imageSelected)
                                .resizable()
                                .scaledToFit()
                                .scaleEffect(scale)
                                .offset(x: position.x + dragOffset.width, y: position.y + dragOffset.height)
                                .gesture(dragGesture)
                                .gesture(magnificationGesture)
                        }
                    }
                    
//                  Device Name
                    if self.validationError && deviceName.count == 0 {
                        Text("Please fill item name")
                            .fontWeight(.medium)
                            .foregroundColor(.red)
                            .padding(0)
                            .frame(width: 340, alignment: .leading)
                    }
                    Group{
                        DynamicTextFiled(label: "* Item Name", text: $deviceName, editable: $editable)
                        
                        
                        //                   Shop Name
                        DynamicTextFiled(label: "Shop Name", text: $shopName, editable: $editable)
                        
                        
                        //                   Warranty Company Name
                        DynamicTextFiled(label:"Warranty\nCompany", text: $companyName, editable: $editable)
                        
                        
                        //                   Choose category
                        if self.validationError && selectedCateg == nil {
                            Text("Please Select Category")
                                .fontWeight(.medium)
                                .foregroundColor(.red)
                                .padding(0)
                                .frame(width: 340, alignment: .leading)
                        }
                        DynamicPicker(
                            label:"* Category:",
                            selection: $selectedCateg,
                            editable: $editable,
                            selector: Catg.allCases.map{
                                (
                                    $0.localizedName.stringValue(),
                                    $0
                                )
                            }
                        )
                    }
                    
//                   Duration
                    Group{
                        Text("Duration of Warranty:")
                            .padding(.leading, 13)
                            .frame(width: 370, alignment: .leading)
                            .font(.headline)
                        DurationComponent(years:$durationYears, months:$durationMonths, days:$durationDays, editable:$editable)
                    }
                    
//                   Warranty Start Date
                    DatePicker("Warranty Start Date:", selection: $selectedDate, displayedComponents: .date)
                        .multilineTextAlignment(.leading)
                        .padding()
                        .frame(width: 370, height: 50)
                        .background(!editable ? Color(.clear) : Color("Gray1"))
                        .cornerRadius(10)
                        .disabled(!editable)
                        .font(.headline)
                    
                    
                    
//                     Remind me
                    DynamicPicker(
                        label:"Remind me before:",
                        selection: $selectedRemind,
                        editable: $editable,
                        selector: RemindmeOption.allCases.map{($0.rawValue,$0)}
                    )
                    
                    
                    Group{
                    
//                    Add Photo (Optional)
//                    Text("Add Photo (Optional)")
//                        .padding(.leading, 10)
//                        .frame(width: 370, alignment: .leading)
//                        .font(.headline)

                        
                        
                        
                        
                        Text("Note:")
                            .padding()
                            .frame(width: 370, alignment: .leading)
                            .font(.headline)
                        
                        if editable {
                            TextField("Note", text: $note, axis: .vertical)
                                .multilineTextAlignment(.leading)
                                .padding()
                                .frame(width: 370)
                                .background(Color("Gray1"))
                                .cornerRadius(10)
                                .lineLimit(6)
                                .multilineTextAlignment(.trailing)
                        } else {
                            Text(note)
                                .frame(width: 370, height: 50, alignment: .leading)
                        }
                    }
                    
                    
                }
            }
            .onAppear{
                if done {
                    return
                }
                updateState()
                done = true
            }
            .padding()
        .navigationTitle("Warranty")
            .navigationBarItems(
                trailing:
                    HStack{
                        addMode ?
                            AnyView(EmptyView())
                        :
                            AnyView(Button(action: {
                                editable = !editable
                                if editable {
                                    self.storeCurrentState()
                                } else {
                                    validationError = false
                                    self.updateState()
                                }
                            }) {
                                Text(editable ? "Cancel" : "Edit")
                                    .fontWeight(.medium)
                                    .foregroundColor(Color("AccentColor"))
                            })
                        editable ?
                        AnyView(
                            Button(action:
                                    {
                                        if self.validate() {
                                            self.addUpdateWarranty()
                                        }
                                    })
                            {
                                addMode ? Text("Save") : Text("Update")
                            }
                            
                        )
                        :
                            AnyView(EmptyView())
                    }
                    
            )
        
    }
}

struct WarrantyPage_Previews: PreviewProvider {
    static var previews: some View {
        
        NavigationView{
            WarrantyPage(selectedCateg: Binding<Catg?>.constant(nil))
                .preferredColorScheme(.dark)
        }
    }
}

