
import SwiftUI

struct OnboardingView: View {
    @State private var goal: String = ""
    @State private var learningGoal: String = ""
    @FocusState private var isInputActive: Bool
    @State private var timeframe: String = "Week"
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()
                
                VStack (spacing: 24) {
                    Spacer().frame(height: 36)
                        
                }
                ZStack {
                    Circle()
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color(red: 0.3, green: 0.02, blue: 0.01),
                                    Color.black
                                ]),
                                startPoint: .topLeading,
                                endPoint: .center
                            )
                        )
                        .frame(width: 120, height: 120)
                        .overlay(
                            Circle()
                                .stroke(
                                    LinearGradient(
                                        colors: [
                                            Color.orange.opacity(0.8),
                                            Color.orange.opacity(0.3)
                                        ],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    ),
                                    lineWidth: 0.9
                                )
                        )

                    Image("flame")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 48, height: 48)
                        .shadow(color: Color.orange.opacity(0.3), radius: 8, x: 0, y: 4)
                }

                .padding(.bottom, 650)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Hello Learner")
                        .font(.system(size: 34, weight: .bold))
                        .foregroundColor(.white)

                    Text("This app will help you learn everyday!")
                        .font(.system(size: 17))
                        .foregroundColor(.gray)
                        .font(.subheadline)
                        
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 10)
                .padding(.bottom, 400)
                
                
                VStack(alignment: .leading, spacing: 12) {
                    Text("I want to learn")
                        .font(.system(size: 22))
                        .foregroundColor(.white)
                        .font(.headline)
                                    
                                    // Topic field
                    TextField("", text: $goal, prompt: Text("Swift")
                        .foregroundColor(Color.gray)
                    )
                    Divider().background(Color.white.opacity(0.5))
                        .background(Color.black)
                        .foregroundColor(.white)
                        .font(.system(size: 17, weight: .regular))
                        .keyboardType(.default)
                        .submitLabel(.done)
                        .focused($isInputActive)
                    
                }
                .padding(.bottom, 200)
                .padding(10)
                
                
                // MARK: - Timeframe Section
                VStack(alignment: .leading, spacing: 12) {   // 👈 this part aligns everything to the left
                    Text("I want to learn it in a")
                        .font(.system(size: 22))
                        .foregroundColor(.white)
                        .font(.headline)
                    
                    HStack(spacing: 14) {
                        ForEach(["Week", "Month", "Year"], id: \.self) { time in
                            Button(action: {
                                timeframe = time
                                isInputActive = false
                            }) {
                                Text(time)
                                    .fontWeight(.semibold)
                                    .frame(width: 90, height: 42)
                                    .background(
                                        ZStack {
                                            if timeframe == time {
                                                // Selected: orange glass effect
                                                LinearGradient(
                                                    colors: [
                                                        Color.orange.opacity(0.9),
                                                        Color.orange.opacity(0.3)
                                                    ],
                                                    startPoint: .topLeading,
                                                    endPoint: .bottomTrailing
                                                )
                                            } else {
                                                // Unselected: dark glass effect
                                                LinearGradient(
                                                    colors: [
                                                        Color.white.opacity(0.08),
                                                        Color.white.opacity(0.03)
                                                    ],
                                                    startPoint: .topLeading,
                                                    endPoint: .bottomTrailing
                                                )
                                            }
                                        }
                                    )
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 21)
                                            .stroke(
                                                timeframe == time
                                                ? Color.orange.opacity(0.9)
                                                : Color.white.opacity(0.08),
                                                lineWidth: 1.2
                                            )
                                    )
                                    .cornerRadius(21)
                                    .shadow(color: timeframe == time ? Color.orange.opacity(0.4) : Color.clear,
                                            radius: 8, x: 0, y: 3)
                                    .foregroundColor(.white)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.horizontal, 12)
                // MARK: - Start Button
                Button(action: {
                    isInputActive = false
                    print("Start learning \(goal) in a \(timeframe)")
                }){ NavigationLink(destination: MiniCalendarView()) {
                    Text("Start learning")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(
                            LinearGradient(
                                colors: [
                                    Color.orange.opacity(0.9),
                                    Color.orange.opacity(0.3)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(
                                    LinearGradient(
                                        colors: [
                                            Color.orange.opacity(0.09),
                                            Color.orange.opacity(0.03)
                                        ],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    ),
                                    lineWidth: 1.2
                                )
                        )
                        .cornerRadius(25)
                        .shadow(color: Color.orange.opacity(0.4), radius: 10, x: 0, y: 4)
                        .foregroundColor(.white)
                        .padding(.horizontal, 110)
                }
                .padding(.top, 16)

                .padding(.top, 600)
                    
                }
            }
        }
    }
}
#Preview {
    OnboardingView()
}
