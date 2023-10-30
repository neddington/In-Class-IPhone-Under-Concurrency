//
//  ContentView.swift
//  In-Class-IPhone-Under-Concurrency
//
//  Created by Eddington, Nick on 10/30/23.
//

import SwiftUI

struct ContentView: View {
    @State private var workProgress: Double = 0.0
    @State private var isWorking = false
    @State private var errorMessage: String?

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")

            Button(action: {
                isWorking = true
                Task {
                    do {
                       try await doWork()
                    } catch {
                        errorMessage = error.localizedDescription
                    }
                    isWorking = false
                }
            }) {
                Text("Do Long Work")
                    .padding()
            }
            .disabled(isWorking)

            Slider(value: $workProgress)
                .padding()

            Text(errorMessage ?? "")
                .foregroundColor(.red)
                .padding()
        }
    }

    func doWork() async throws {
        for _ in 0..<100 {
            // Simulate some work
            try await Task.sleep(nanoseconds: 100_000_000) // Sleep for 0.1 seconds
            workProgress += 0.01
        }
    }
}

#Preview {
    ContentView()
}
