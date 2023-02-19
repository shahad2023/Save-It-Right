///
//  OnBoarding.swift
//  SaveItRight
//
//  Created by Lamia AlSiddiqi on 14/07/1444 AH.
//

import SwiftUI

struct OnBoardingSteps {
    let image: String
    let description: String
}

private let onBoardingSteps = [
    OnBoardingSteps(image: "OnBoarding1", description: "Save your Warranties in One Place"),
    OnBoardingSteps(image: "OnBoarding2", description: "Categorize your Warranties"),
    OnBoardingSteps(image: "OnBoarding3", description: "Take the Advantage of the Warranty Before it Ends")
]
struct OnBoarding: View {
    @State private var currentStep = 0
    
    init() {
        UIScrollView.appearance().bounces = false
    }
    
    var body: some View {
        
       
        ZStack {
//            Color.black
//                .ignoresSafeArea()
            VStack{
                HStack{
                    Spacer()
                    Button(action: {
                        self.currentStep = onBoardingSteps.count - 1
                    }){
                        Text("Skip")
                            .padding(16)
                            .foregroundColor(Color(red: 0.022, green: 0.689, blue: 0.998))
                    }
                }
                TabView(selection: $currentStep){
                    ForEach(0..<onBoardingSteps.count) { it in
                        VStack{
                            Image(onBoardingSteps[it].image)
                                .resizable()
                                .frame(width: 350, height:350)
                            
                            Text(onBoardingSteps[it].description)
                                .font(.title)
                                .bold()
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white)
                                .padding(.horizontal,32)
                                .padding(.top,16)
                        }
                        .tag(it)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
                HStack{
                    ForEach(0..<onBoardingSteps.count) { it in
                        if it == currentStep {
                            Rectangle()
                                .frame(width: 20, height: 10)
                                .cornerRadius(10)
                                .foregroundColor(Color(red: 0.022, green: 0.689, blue: 0.998))
                        } else {
                            Circle()
                                .frame(width: 10, height: 10)
                                .foregroundColor(.white)
                            
                        }
                    }
                }
                .padding(.bottom, 24)
                
                Button(action:{
                    if self.currentStep < onBoardingSteps.count - 1 {
                        self.currentStep += 1
                    }else {
                        // Get Started Logic
                    }
                }) {
                    Text(currentStep < onBoardingSteps.count - 1 ? "Next" : "Get started")
                        .padding(16)
                        .frame(maxWidth: .infinity)
                        .background(Color(red: 0.022, green: 0.689, blue: 0.998))
                        .cornerRadius(16)
                        .padding(.horizontal, 16)
                        .foregroundColor(.white)
                }
                .buttonStyle(PlainButtonStyle())
                    
            }
        }
        }
    }


struct OnBoarding_Previews: PreviewProvider {
    static var previews: some View {
        OnBoarding()
            .preferredColorScheme(.dark)

    }
}
