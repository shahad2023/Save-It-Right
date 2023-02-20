//
//  logo.swift
//  Save It Right
//
//  Created by Shahad Mohammed on 24/07/1444 AH.
//

import SwiftUI

struct logo: View {
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    var body: some View {

        if  isActive {
            MainPage()
                .preferredColorScheme(.dark)
                .tint(.accentColor)
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environment(\.managedObjectContext, PersistenceController.managedContext)
//            OnBoarding()
        } else{
            ZStack {

                Color.black
                        .ignoresSafeArea()
                VStack{
                    Image("logo_en")
                    Text(LocalizedStringKey("Don’t Worry and Save it Right"))
                .font(.title2)
                .foregroundColor(Color(red: 0.022, green: 0.689, blue: 0.998))
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear{
                    withAnimation(.easeIn(duration: 1.2)){
                        self.size = 0.9
                        self.opacity = 1.0
                    }
                }
            }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
                self.isActive = true
            }
        }
        }





    }

}

struct logo_Previews: PreviewProvider {
    static var previews: some View {
        logo()
            .preferredColorScheme(.dark)
    }
}


