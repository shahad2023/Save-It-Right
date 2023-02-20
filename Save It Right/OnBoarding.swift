import SwiftUI

struct OnBoarding: View {
    @AppStorage("_shouldShowOnBoarding") var shouldShowOnBoarding: Bool = true
    
    var body: some View {
        MainPage()
        .fullScreenCover(isPresented: $shouldShowOnBoarding, content: {
            OnBoardingView(shouldShowOnBoarding: $shouldShowOnBoarding)
                .preferredColorScheme(.dark)
            
        })
    }
}

//OnBoarding

struct OnBoardingView: View {
    @Binding var shouldShowOnBoarding: Bool
    
    var body: some View {
        TabView {
            PageView(
                title: "Save your Warranties in One Place",
                image: "OnBoarding1",
                showsDismissButton: false,
                shouldShowOnBoarding: $shouldShowOnBoarding
            )
            
            PageView(
                title: "Categorize your Warranties",
                image: "OnBoarding2", showsDismissButton: false,
                shouldShowOnBoarding: $shouldShowOnBoarding
                
            )
            
            PageView(
                title: "Take the Advantage of the Warrantiy Before it Ends",
                image: "OnBoarding3",
                showsDismissButton: true,
                shouldShowOnBoarding: $shouldShowOnBoarding
                
            )
            
        }
        .tabViewStyle(PageTabViewStyle())
    }
}

struct PageView: View {
    let title: String
    let image: String
    let showsDismissButton: Bool
    @Binding var shouldShowOnBoarding: Bool
    
    var body: some View {
        VStack {
            if !showsDismissButton {
                HStack{
                    Spacer()
                    Button(action: {
                        shouldShowOnBoarding.toggle()
                        
                        
                    }, label: {
                        Text("Skip")
                            .bold()
                            .foregroundColor(Color("Blue2"))
                            .cornerRadius(6)
                    })
                }
//                .padding(.top , -200)
//                .padding(.trailing , 40.0)
            }
            Spacer()
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 250, height: 250)
                .padding()
            
            Text(title)
                .font(.system(size: 32))
                .multilineTextAlignment(.center)
                .padding()
            
            
            if showsDismissButton {
                Button(action: {
                    shouldShowOnBoarding.toggle()
                    
                    
                }, label: {
                    Text("Get Started")
                        .bold()
                        .foregroundColor(.white)
                        .frame(width: 200, height: 50)
                        .background(Color("Blue2"))
                        .cornerRadius(6)
                })
            }
            Spacer()
        }
    }
}
struct OnBoarding_Previews: PreviewProvider {
    static var previews: some View {
        OnBoarding()
            .preferredColorScheme(.dark)
    }
}
