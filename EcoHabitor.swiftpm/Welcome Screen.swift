import SwiftUI

struct WelcomeScreen: View {
    @State private var navigateToMainTabView = false
    var body: some View {
        NavigationStack {
            VStack(spacing: 40.0) {
                Spacer()
                
                // App Logo or Illustration
                Image(systemName: "leaf.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .foregroundColor(.green)
                    .shadow(radius: 10)
                
                // Title
                Text("Welcome to EcoHabit Calculator")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                // Subtitle/Description
                Text("Track your habits, reduce your carbon footprint, and make the planet a better place. Start building eco-friendly habits today!")
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
                    .padding(.horizontal, 30)
                
                Spacer()
                
                
                Button(action: {
                    navigateToMainTabView = true
                }) {
                    Text("Get Started")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(10)
                    .padding(.horizontal)
                }
                Spacer()
                
                // NavigationLink to HomeScreen
                /*
                NavigationLink(destination: HomeScreen(historyViewModel: HistoryViewModel())) {
                    Text("Get Started")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .cornerRadius(12)
                        .shadow(radius: 5)
                }
                .padding(.horizontal, 40)
                
                Spacer()
                 */
                
            }
            .navigationBarBackButtonHidden(true)
            .navigationDestination(isPresented: $navigateToMainTabView) {
                MainTabView()
            }
        }
    }
}

struct WelcomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen(historyViewModel: HistoryViewModel())
    }
}
