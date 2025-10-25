import SwiftUI

struct MiniCalendarView: View {
    // MARK: - State
    @State private var currentDate: Date = Date()
    @State private var showMonthYearMenu: Bool = false
    @State private var selectedYear: Int = Calendar.current.component(.year, from: Date())
    @State private var selectedMonth: Int = Calendar.current.component(.month, from: Date())
    private var calendar = Calendar.current
    
    // MARK: - Computed properties
    private var monthTitle: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: currentDate)
    }
    
    // MARK: - Select new month/year
    private func select(month: Int, year: Int) {
        var components = calendar.dateComponents([.year, .month], from: Date())
        components.year = year
        components.month = month
        components.day = 1
        if let newDate = calendar.date(from: components) {
            currentDate = newDate
            selectedYear = year
            selectedMonth = month
        }
    }
    
    // MARK: - Move one week
    private func moveWeek(byWeeks weeks: Int) {
        if let newDate = calendar.date(byAdding: .day, value: weeks * 7, to: currentDate) {
            currentDate = newDate
        }
    }
    
    // MARK: - Body
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack {
                VStack(alignment: .leading, spacing: 10) {
                    // MARK: Calendar section
                    headerSection
                    weekRow
                    
                    Divider()
                        .background(Color.white.opacity(0.5))
                        .padding(.vertical, 8)
                    
                    // MARK: Streak section (progress cards)
                    streakSection
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: 200)
                .padding(31)
                .background(
                    RoundedRectangle(cornerRadius: 22)
                        .fill(Color(red: 0.10, green: 0.10, blue: 0.10))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 22)
                        .stroke(Color.white.opacity(0.50), lineWidth: 1)
                )
                .padding()
                
                Spacer()
            }
            
            // MARK: Floating Popup
            if showMonthYearMenu {
                Color.black.opacity(0.3).ignoresSafeArea()
                    .onTapGesture {
                        withAnimation(.easeOut(duration: 0.20)) {
                            showMonthYearMenu = false
                        }
                    }
                
                MonthYearPickerView(
                    selectedMonth: $selectedMonth,
                    selectedYear: $selectedYear,
                    isPresented: $showMonthYearMenu
                )
                //.frame(width: 300, height: 200)
                .background(
                    RoundedRectangle(cornerRadius: 40)
                        .fill(Color(.systemBackground))
                )
                .transition(AnyTransition.offset(x: 0, y: -40))
                .zIndex(1)
                .offset(y: -200)
                .onChange(of: selectedMonth, initial: false) { oldValue, newValue in
                    select(month: newValue, year: selectedYear)
                }
                .onChange(of: selectedYear, initial: false) { oldValue, newValue in
                    select(month: selectedMonth, year: newValue)
                }
            }
        }
        .preferredColorScheme(.dark)
        .environment(\.colorScheme, .dark)
    }
    
    // MARK: - Header
    private var headerSection: some View {
        HStack {
            HStack(spacing: 7) {
                Text(monthTitle)
                    .font(.headline)
                    .foregroundColor(.white)
                
                Button(action: {
                    withAnimation(.spring(response: 0.45, dampingFraction: 0.8)) {
                        showMonthYearMenu.toggle()
                    }
                }) {
                    Image(systemName: "chevron.right")
                        .foregroundColor(.orange)
                        .imageScale(.medium)
                        .rotationEffect(.degrees(showMonthYearMenu ? 90 : 0))
                        .animation(.easeInOut(duration: 0.25), value: showMonthYearMenu)
                }
            }
            
            Spacer()
            
            HStack(spacing: 20) {
                Button(action: { withAnimation { moveWeek(byWeeks: -1) } }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.orange)
                        .imageScale(.medium)
                }
                Button(action: { withAnimation { moveWeek(byWeeks: +1) } }) {
                    Image(systemName: "chevron.right")
                        .foregroundColor(.orange)
                        .imageScale(.medium)
                }
            }
        }
    }
    
    // MARK: - Week row
    private var weekRow: some View {
        let weekday = calendar.component(.weekday, from: currentDate)
        let startOfWeek = calendar.date(byAdding: .day, value: -((weekday - 1) % 7), to: currentDate)!
        let days = (0..<7).compactMap { calendar.date(byAdding: .day, value: $0, to: startOfWeek) }
        
        return HStack(spacing: 14) {
            ForEach(days, id: \.self) { date in
                VStack(spacing: 6) {
                    Text(shortWeekday(for: date))
                        .font(.caption2)
                        .foregroundColor(.white.opacity(0.6))
                    Circle()
                        .fill(Color.white.opacity(0.1))
                        .frame(width: 36, height: 36)
                        .overlay(Text(dayNumber(for: date)).foregroundColor(.white))
                }
            }
        }
    }
    
    // MARK: - Streak Section
    private var streakSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Learning Swift")
                .font(.headline)
                .foregroundColor(.white)
            
            HStack(spacing: 16) {
                progressCard(
                    icon: "flame.fill",
                    number: "3",
                    subtitle: "Days Learned",
                    fillColor: Color.orange.opacity(0.20),
                    borderColor: Color.orange.opacity(0.6),
                    iconColor: .orange
                )
                progressCard(
                    icon: "cube.fill",
                    number: "1",
                    subtitle: "Days Frozen",
                    fillColor: Color.blue.opacity(0.15),
                    borderColor: Color.blue.opacity(0.6),
                    iconColor: .teal
                )
            }
        }
    }
    
    // MARK: - Single progress card
    private func progressCard(
        icon: String,
        number: String,
        subtitle: String,
        fillColor: Color,
        borderColor: Color,
        iconColor: Color
    ) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 40)
                .fill(fillColor)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(borderColor, lineWidth: 0)
                )

            HStack(spacing: 7) {
                // Icon stays on the left
                Image(systemName: icon)
                    .font(.system(size: 20))
                    .foregroundColor(iconColor)

                // Number above subtitle on the right
                VStack(alignment: .leading, spacing: 2) {
                    Text(number)
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                    Text(subtitle)
                        .font(.system(size: 14))
                        .foregroundColor(.white)
                }

                Spacer(minLength: 2)
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 1)
        }
        .frame(width: 160, height: 70)
    }

    // MARK: - Helpers
    private func shortWeekday(for date: Date) -> String {
        let f = DateFormatter()
        f.dateFormat = "EEE"
        return f.string(from: date).uppercased()
    }
    
    private func dayNumber(for date: Date) -> String {
        let f = DateFormatter()
        f.dateFormat = "d"
        return f.string(from: date)
    }
}

// MARK: - MonthYearPickerView
struct MonthYearPickerView: View {
    @Binding var selectedMonth: Int
    @Binding var selectedYear: Int
    @Binding var isPresented: Bool
    
    private let months = Calendar.current.monthSymbols
    private let years = Array(2000...2100)
    
    var body: some View {
        VStack(spacing: 12) {
            HStack(spacing: 0) {
                Picker("Month", selection: $selectedMonth) {
                    ForEach(1...12, id: \.self) { index in
                        Text(months[index - 1]).tag(index)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(width: 140)
                
                Picker("Year", selection: $selectedYear) {
                    ForEach(years, id: \.self) { year in
                        Text(String(year)).tag(year)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(width: 140)
            }
            .labelsHidden()
            .padding()
        }
        .padding(.top)
    }
}

#Preview {
    MiniCalendarView()
        .preferredColorScheme(.dark)
}
