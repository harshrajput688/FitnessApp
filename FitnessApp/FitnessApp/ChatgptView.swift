import SwiftUI

struct FitnessDashboardView: View {
    var body: some View {
        VStack(spacing: 20) {
            // Header Section
            Text("Welcome")
                .font(.largeTitle)
                .fontWeight(.bold)

            // Activity Rings
            ZStack {
                RingView(color: .red, progress: 0.5, totalProgress: 1.0, size: 150)
                RingView(color: .green, progress: 0.4, totalProgress: 1.0, size: 120)
                RingView(color: .blue, progress: 0.8, totalProgress: 1.0, size: 90)
            }

            // Activity Details
            HStack(spacing: 20) {
                VStack(alignment: .leading) {
                    Text("Calories")
                        .foregroundColor(.red)
                    Text("123 kcal")
                }
                VStack(alignment: .leading) {
                    Text("Active")
                        .foregroundColor(.green)
                    Text("52 min")
                }
                VStack(alignment: .leading) {
                    Text("Stand")
                        .foregroundColor(.blue)
                    Text("8 hours")
                }
            }

            // Fitness Activity Section
            HStack {
                Text("Fitness Activity")
                    .font(.headline)
                Spacer()
                Button(action: {}) {
                    Text("Show More")
                        .foregroundColor(.blue)
                }
            }
            .padding(.horizontal)

            // Steps Data
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 20) {
                FitnessCard(title: "Today steps", value: "6000", goal: "Goal 12,000", iconColor: .green)
                FitnessCard(title: "Today", value: "812", goal: "Goal 1,000", iconColor: .red)
                FitnessCard(title: "Today steps", value: "15,000", goal: "Goal 12,000", iconColor: .blue)
                FitnessCard(title: "Today steps", value: "6,000", goal: "Goal 12,000", iconColor: .orange)
            }
            .padding(.horizontal)
        }
        .padding()
    }
}

struct RingView: View {
    var color: Color
    var progress: CGFloat
    var totalProgress: CGFloat
    var size: CGFloat

    var body: some View {
        ZStack {
            Circle()
                .stroke(color.opacity(0.3), style: StrokeStyle(lineWidth: 20, lineCap: .round))
                .frame(width: size, height: size)
            Circle()
                .trim(from: 0.0, to: progress / totalProgress)
                .stroke(color, style: StrokeStyle(lineWidth: 20, lineCap: .round))
                .rotationEffect(.degrees(-90))
                .frame(width: size, height: size)
        }
    }
}

struct FitnessCard: View {
    var title: String
    var value: String
    var goal: String
    var iconColor: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(title)
                    .font(.subheadline)
                Spacer()
                Image(systemName: "figure.walk")
                    .foregroundColor(iconColor)
            }

            Text(value)
                .font(.title)
                .fontWeight(.bold)

            Text(goal)
                .font(.footnote)
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}

struct FitnessDashboardView_Previews: PreviewProvider {
    static var previews: some View {
        FitnessDashboardView()
    }
}
