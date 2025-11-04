//
//  ContentView.swift
//  WorkoutKitSyncWatch
//
//  Sample watchOS app for testing WorkoutKitSync
//

import SwiftUI
import WorkoutKitSync

struct ContentView: View {
    @State private var isLoading = false
    @State private var message = ""
    
    private let sampleJSON = """
{
  "title": "Quick Strength Workout",
  "sportType": "strengthTraining",
  "intervals": [
    {
      "kind": "repeat",
      "reps": 3,
      "intervals": [
        {
          "kind": "reps",
          "reps": 10,
          "name": "Push Ups",
          "load": null,
          "restSec": 30
        },
        {
          "kind": "reps",
          "reps": 12,
          "name": "Squats",
          "load": null,
          "restSec": 30
        }
      ]
    }
  ],
  "schedule": null
}
"""
    
    var body: some View {
        ScrollView {
            VStack(spacing: 15) {
                Text("WorkoutKit Sync")
                    .font(.headline)
                
                Button(action: {
                    Task {
                        await importWorkout()
                    }
                }) {
                    if isLoading {
                        ProgressView()
                    } else {
                        Text("Import Workout")
                            .font(.caption)
                    }
                }
                .disabled(isLoading)
                
                if !message.isEmpty {
                    Text(message)
                        .font(.caption2)
                        .foregroundColor(message.contains("✅") ? .green : .red)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
            }
            .padding()
        }
    }
    
    private func importWorkout() async {
        isLoading = true
        message = ""
        
        do {
            try await WorkoutKitSync.default.parseAndSave(from: sampleJSON)
            message = "✅ Imported! Check Fitness app"
        } catch {
            message = "❌ Error: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
}

#Preview {
    ContentView()
}
