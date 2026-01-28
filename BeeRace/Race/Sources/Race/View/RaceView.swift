//
//  RaceView.swift
//  Race
//
//  Created by Joao Barbosa on 26/01/2026.
//

import SwiftUI
import Models

struct RaceView: View {

    @ObservedObject var viewModel: RaceViewModel

    var body: some View {
        VStack(spacing: 0) {
            if viewModel.error == nil {
                VStack(spacing: 0) {
                    Text("Time remaining")
                        .foregroundStyle(.white)
                    Text(formatDuration(viewModel.durationRemaining ?? 0))
                        .foregroundStyle(.white)
                        .font(.largeTitle)
                        .padding()
                }
                .frame(maxWidth: .infinity)
                .frame(height: 150)
                .background(.black)
                ScrollView {
                    LazyVStack(spacing: 0) {
                        ForEach(viewModel.raceStatus, id: \.name) { bee in
                            BeeCell(
                                bee: bee,
                                position: viewModel.position(of: bee),
                                color: bee.color
                            )
                            Divider()
                        }
                    }
                    .animation(.smooth, value: viewModel.raceStatus)
                }
                .padding(.horizontal)
            }
            else {
                VStack(spacing: 0) {
                    Text("Oops!!")
                        .font(.largeTitle)
                        .padding()
                    Text("Something went wrong\n\(viewModel.error?.localizedDescription ?? "No description)")")
                        .font(.title)
                        .padding(.horizontal)
                        .padding(.bottom)
                    Text("Don't worry we are on it")
                        .font(.title2)
                        .padding(.horizontal)
                        .padding(.bottom)

                    Button {
                        viewModel.startNewRace()
                    } label: {
                        Text("Ok")
                            .fontWeight(.semibold)
                            .padding()
                            .background(Color.black)
                            .foregroundColor(.white)
                    }
                }
            }
        }
        .onAppear(perform: {
           // viewModel.startNewRace()
        })
        .ignoresSafeArea(.container, edges: .bottom)
    }

    private func formatDuration(_ seconds: Int) -> String {
        let minutes = seconds / 60
        let remainingSeconds = seconds % 60
        return String(format: "%02d:%02d", minutes, remainingSeconds)
    }
}

struct BeeCell: View {
    let bee: Bee
    let position: Int
    let color: String

    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            Image("bee_icon")
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
                .padding(12)
                .background(Color(hex: color))
                .clipShape(Circle())
                .padding(.horizontal)

            VStack(alignment: .leading, spacing: 0) {
                Text(position.ordinal)
                    .padding(.bottom, 4)
                Text(bee.name)
                    .font(.caption)
            }
            Spacer()

            if let medalImageName {
                Image(medalImageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .padding(12)
                    .padding(.horizontal)
            }
        }
        .padding(.vertical)
    }

    private var medalImageName: String? {
        switch position {
        case 1:
            return "gold"
        case 2:
            return "silver"
        case 3:
            return "bronze"
        default:
            return nil
        }
    }
}

extension Int {
    var ordinal: String {
        let suffix: String
        let ones = self % 10
        let tens = (self / 10) % 10
        if tens == 1 {
            suffix = "th" // 11, 12, 13
        } else {
            switch ones {
            case 1: suffix = "st"
            case 2: suffix = "nd"
            case 3: suffix = "rd"
            default: suffix = "th"
            }
        }
        return "\(self)\(suffix)"
    }
}

extension Color {
    init?(hex: String) {
        var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexString = hexString.replacingOccurrences(of: "#", with: "")
        guard hexString.count == 6 else { return nil }

        let scanner = Scanner(string: hexString)
        var rgb: UInt64 = 0

        guard scanner.scanHexInt64(&rgb) else { return nil }

        let r = Double((rgb & 0xFF0000) >> 16) / 255.0
        let g = Double((rgb & 0x00FF00) >> 8) / 255.0
        let b = Double(rgb & 0x0000FF) / 255.0

        self.init(red: r, green: g, blue: b)
    }
}
