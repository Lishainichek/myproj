
import SwiftUI

struct DashboardView: View {
    @StateObject private var vm = DashboardVM()

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {

                Text("Swift Charts Demo")
                    .font(.title2)
                    .bold()

                .pickerStyle(.segmented)
                GroupBox("Interactive line chart (drag to select)") {
                    InteractiveLineChart(
                        data: vm.data,
                        yDomain: vm.yDomain,
                        target: vm.targetValue
                    )
                }
            }
            .padding()
        }
    }
}
