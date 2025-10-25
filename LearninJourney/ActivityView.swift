import SwiftUI

struct ActivityView: View {
    var body: some View {
        ZStack{
            Color.black.ignoresSafeArea()
            VStack (spacing:0) {
                headerSection
                MiniCalendarView()
                    .frame(height: 750)
                //progressSection
                //actionButtons
                Spacer()
            }
            .padding()
        }
        .preferredColorScheme(.dark)
    }
    //MARK : - Header
    private var headerSection: some View {
        HStack(alignment: .center){
            Text("Activity")
                .font(.system(size: 32, weight: .bold))
                .foregroundColor(.white)
            Spacer()
            HStack(spacing: 14){
                Button(action: {
                    
                }) {
                    ZStack{
                        Circle()
                            .fill(Color.white.opacity(0.2))
                            .frame(width: 40, height: 40)
                            .overlay(
                                Circle()
                                    .stroke(Color.white.opacity(0.6), lineWidth: 1)
                            )
                        Image(systemName: "calendar")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundColor(.white)
                        }
                    }
                Button(action: {
                    
                }) {
                    ZStack{
                        Circle()
                            .fill(Color.white.opacity(0.2))
                            .frame(width: 40, height: 40)
                            .overlay(
                                Circle()
                                    .stroke(Color.white.opacity(0.6), lineWidth: 1)
                            )
                        Image(systemName: "pencil.and.outline")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundColor(.white)
                        }
                    }
                }
            }
        .padding(.horizontal,24)
        .padding(.top , 10)
        .padding(.bottom, 4)
        }
    }
#Preview {
    ActivityView()
}


