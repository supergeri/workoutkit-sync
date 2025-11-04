//
//  ContentView.swift
//  WorkoutKitSyncTest
//
//  Sample iOS app for testing WorkoutKitSync
//

import SwiftUI
import WorkoutKitSync

struct ContentView: View {
    @State private var isLoading = false
    @State private var message = ""
    @State private var jsonInput = """
{
  "title": "Imported Workout",
  "sportType": "strengthTraining",
  "intervals": [
    {
      "kind": "repeat",
      "reps": 3,
      "intervals": [
        {
          "kind": "reps",
          "reps": 10,
          "name": "Bar Good Morning",
          "load": null,
          "restSec": null
        },
        {
          "kind": "reps",
          "reps": 12,
          "name": "Plank",
          "load": null,
          "restSec": null
        },
        {
          "kind": "distance",
          "meters": 20,
          "target": null
        }
      ]
    },
    {
      "kind": "repeat",
      "reps": 4,
      "intervals": [
        {
          "kind": "reps",
          "reps": 5,
          "name": "Dumbbell Front Squat",
          "load": null,
          "restSec": null
        },
        {
          "kind": "reps",
          "reps": 4,
          "name": "Burpee",
          "load": null,
          "restSec": null
        },
        {
          "kind": "reps",
          "reps": 10,
          "name": "Single Arm Kettlebell Swing",
          "load": null,
          "restSec": null
        }
      ]
    },
    {
      "kind": "repeat",
      "reps": 3,
      "intervals": [
        {
          "kind": "distance",
          "meters": 60,
          "target": null
        },
        {
          "kind": "reps",
          "reps": 25,
          "name": "Dumbbell Push Press",
          "load": null,
          "restSec": null
        },
        {
          "kind": "time",
          "seconds": 45,
          "target": null
        },
        {
          "kind": "distance",
          "meters": 27,
          "target": null
        },
        {
          "kind": "reps",
          "reps": 8,
          "name": "Hand Release Push Up",
          "load": null,
          "restSec": null
        }
      ]
    },
    {
      "kind": "repeat",
      "reps": 3,
      "intervals": [
        {
          "kind": "time",
          "seconds": 60,
          "target": null
        },
        {
          "kind": "time",
          "seconds": 90,
          "target": null
        }
      ]
    }
  ],
  "schedule": null
}
"""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("WorkoutKit Sync Test")
                    .font(.largeTitle)
                    .bold()
                    .padding()
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("JSON Input:")
                            .font(.headline)
                        
                        TextEditor(text: $jsonInput)
                            .font(.system(.body, design: .monospaced))
                            .frame(height: 300)
                            .border(Color.gray.opacity(0.3))
                            .cornerRadius(8)
                    }
                    .padding()
                }
                
                Button(action: {
                    Task {
                        await importWorkout()
                    }
                }) {
                    if isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                    } else {
                        Text("Import Workout")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                }
                .disabled(isLoading)
                .padding(.horizontal)
                
                if !message.isEmpty {
                    Text(message)
                        .foregroundColor(message.contains("✅") ? .green : .red)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                        .padding(.horizontal)
                }
                
                Spacer()
            }
            .navigationTitle("WorkoutKit Sync")
        }
    }
    
    private func importWorkout() async {
        isLoading = true
        message = ""
        
        do {
            try await WorkoutKitSync.default.parseAndSave(from: jsonInput)
            message = "✅ Workout plan imported successfully! Check the Fitness app on your iPhone or Apple Watch."
        } catch {
            message = "❌ Error: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
}

#Preview {
    ContentView()
}
