import SwiftUI

struct WelcomeScreen: View {
    @State private var navigateToMainTabView = false
    @State private var isAnimating = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 40.0) {
                Spacer()
                
                
                Image(systemName: "leaf.circle.fill").resizable().scaledToFit().frame(width: 150, height: 150)
                    .foregroundColor(.green)
                    .shadow(color: Color.green.opacity(0.3), radius: 10, x: 0, y: 5)
                    .shadow(color: Color.green.opacity(0.2), radius: 20, x: 0, y: 10)
                    .scaleEffect(isAnimating ? 1.0 : 0.8)
                    .animation(.spring(response: 0.5, dampingFraction: 0.6), value: isAnimating)
                
                
                Text("Welcome to EcoHabit Calculator").font(.system(.largeTitle, design: .rounded)).fontWeight(.bold)
                    .foregroundStyle(LinearGradient(colors: [.green, .blue.opacity(0.7)], startPoint: .leading, endPoint: .trailing))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .opacity(isAnimating ? 1 : 0)
                    .offset(y: isAnimating ? 0 : 20)
                
                
                Text("Track your habits, reduce your carbon footprint, and make the planet a better place. Start building eco-friendly habits today!").font(.system(.body, design: .rounded)).multilineTextAlignment(.center)
                    .foregroundStyle(LinearGradient(colors: [.primary], startPoint: .top, endPoint: .bottom))
                    .padding(.horizontal, 18)
                    .padding(.vertical)
                    .background(RoundedRectangle(cornerRadius: 15).fill(.ultraThinMaterial).shadow(color: .green.opacity(0.7), radius: 10)
                    ).padding(12).opacity(isAnimating ? 1 : 0).offset(y: isAnimating ? 0 : 20)
                
                Spacer()
                
                
                Button(action: {
                    navigateToMainTabView = true
                }) {
                    Text("Get Started").font(.system(.headline, design: .rounded)).fontWeight(.bold).foregroundColor(.white).frame(maxWidth: .infinity).padding()
                        .background(LinearGradient(colors: [.green, .green.opacity(0.8)], startPoint: .topLeading, endPoint: .bottomTrailing)
                        ).cornerRadius(15).shadow(color: .green.opacity(0.3), radius: 5).padding(.horizontal)
                }
                .scaleEffect(isAnimating ? 1.0 : 0.9)
                
                Spacer()
            }
            .onAppear {
                withAnimation(.easeOut(duration: 0.8)) {
                    isAnimating = true
                }
            }
            .navigationDestination(isPresented: $navigateToMainTabView) {
                MainTabView()
                    .navigationBarBackButtonHidden(true)
            }
        }
    }
}
