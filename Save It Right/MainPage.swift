//
//  ContentView.swift
//  Save_It_Right
//
//  Created by Shouq Turki Bin Tuwaym on 05/02/2023.
//

import SwiftUI

struct SectionContent{
    var image:UIImage
    var catg:Catg
}

var values = [
    SectionContent(
        image:UIImage(imageLiteralResourceName: "Jeweleries"),
        catg:.Jeweleries
    ),
    SectionContent(
        image:UIImage(imageLiteralResourceName: "Sport Equipm"),
        catg:.Sports
    ),
    SectionContent(
        image:UIImage(imageLiteralResourceName: "Electronic Device"),
        catg:.Electronic
    ),
    SectionContent(
        image:UIImage(imageLiteralResourceName: "Houseware"),
        catg: .Houseware
    ),
    SectionContent(
        image:UIImage(imageLiteralResourceName: "Spare Parts"),
        catg:.Spare
    ),
    SectionContent(
        image:UIImage(imageLiteralResourceName: "Others"),
        catg:.Others
    )
]




struct BoxView: View {
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    @Environment(\.managedObjectContext) var moc
    
    let sectionContent: SectionContent
    
    var body: some View {
        //        NavigationLink(destination: SwiftUIView(sourceLink:self.sectionContent.text)){
        NavigationLink(destination:
            WarrantiesList(
                category:
                    sectionContent.catg
            ).environment(
            \.managedObjectContext,
             self.moc
        ), label: {
            ZStack(alignment: .bottomLeading){
                Image(uiImage: self.sectionContent.image)
                    .resizable()
                    .scaledToFit()
                    .frame(
                        minWidth: fixWidthSize(
                            imgSize: self.sectionContent.image.size,
                            viewSize: UIScreen.main.bounds.size,
                            safeArea: safeAreaInsets,
                            height: 150,
                            devider: 2,
                            margins: 14 * 2 + 7
                        ),
                        minHeight: fixHeightSize(
                            imgSize: self.sectionContent.image.size,
                            viewSize: UIScreen.main.bounds.size,
                            safeArea: safeAreaInsets,
                            height: 150,
                            devider: 2,
                            margins: 14 * 2 + 7
                        )
                    )
                //                .frame(
                //                    minWidth: 0,
                //                    maxWidth: .infinity
                //                )
                    .frame(
                        width: ( ( UIScreen.main.bounds.size.width - (14 * 2 + 7) - safeAreaInsets.leading - safeAreaInsets.trailing ) /  2 ),
                        height: 150
                    )
                    .clipped()
                LinearGradient(
                    gradient: Gradient(
                        colors: [
                            Color(red: 0.0, green: 0.0, blue: 0.0, opacity: 1),
                            Color(red: 0.0, green: 0.0, blue: 0.0, opacity: 0.0),
                            Color(red: 0.0, green: 0.0, blue: 0.0, opacity: 0.0),
                            Color(red: 0.0, green: 0.0, blue: 0.0, opacity: 0.0)
                        ]
                    ),
                    startPoint: .bottom, endPoint: .top
                )
                Text(self.sectionContent.catg.localizedName).foregroundColor(.white)
                    .padding(5)
            }
        })
        .frame(
            minWidth: 0,
            maxWidth: .infinity
        )
        .frame(height: 150)
        .cornerRadius(10)
        .padding(0)
    }
    //        .navigationBarBackButtonHidden(true)
}
//}



struct MainPage: View {
    
    @Environment(\.managedObjectContext) var moc
    
    init() {
        //Use this if NavigationBarTitle is with Large Font
//        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
//    @State var searchText = ""
    @State var category:Catg? = nil
    
    
    var body: some View {
        NavigationView{
                
                ScrollView {
                    Text("My Warranties")
                        .font(.title2)
                        .fontWeight(.semibold)
//                        .foregroundColor(.white)
                        .frame(width: 370, alignment: .leading)
                        .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                    
                    ForEach(
                        0 ..< Int(
                            ceil(
                                Double(values.count)/2.0
                            )
                        ),
                        id: \.self
                    ) { i in
                        HStack(spacing: 7) {
                            BoxView(sectionContent: values[i*2])
                            if(i*2+1 < values.count){
                                BoxView(sectionContent: values[i*2+1])
                            }
                        }
                    }
                }
                .scrollContentBackground(.hidden)
                .padding(14)
//                .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))

                
                
                
                
                .navigationBarTitle("Warranty", displayMode: .large)
                .navigationBarItems(
                    trailing:
                        NavigationLink( destination: WarrantyPage(addMode:true, selectedCateg: $category, editable:true).environment(
                            \.managedObjectContext,
                             self.moc)
                                      )
                    {
                        Image(systemName: "plus")
                            .foregroundColor(Color("Blue2"))
                            .imageScale(.large)
                    }
                )
                .onAppear{
                    category = nil
                    UNUserNotificationCenter.current().removeAllDeliveredNotifications()
                    UIApplication.shared.applicationIconBadgeNumber = 0
                }
        }
    }
}


struct MainPage_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
            .preferredColorScheme(.dark)
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
