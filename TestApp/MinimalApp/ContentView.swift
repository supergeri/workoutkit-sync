//
//  ContentView.swift
//  Minimal Workout Uploader
//
//  Minimal app - just uploads workouts, no complex UI
//

import SwiftUI
import WorkoutKitSync

struct ContentView: View {
    @State private var isUploading = false
    @State private var message = "Ready to upload"
    
    // Sample workout - you can modify this
    private let workoutJSON = """
{
  "title": "Quick Workout",
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
          "restSec": 30
        },
        {
          "kind": "reps",
          "reps": 12,
          "name": "Squats",
          "restSec": 30
        }
      ]
    }
  ]
}
"""
    
    var body: some View {
        VStack(spacing: 30) {
            Spacer()
            
            Image(systemName: "figure.strengthtraining.traditional")
                .font(.system(size: 60))
                .foregroundColor(.blue)
            
            Text("Workout Uploader")
                .font(.title)
                .bold()
            
            Text(message)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Button(action: {
                Task {
                    await uploadWorkout()
                }
            }) {
                if isUploading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .frame(width: 200, height: 50)
                } else {
                    Text("Upload Workout")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 200, height: 50)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            }
            .disabled(isUploading)
            
            Spacer()
        }
        .padding()
    }
    
    private func uploadWorkout() async {
        isUploading = true
        message = "Uploading..."
        
        do {
            try await WorkoutKitSync.default.parseAndSave(from: workoutJSON)
            message = "✅ Uploaded!\nCheck Fitness app"
        } catch {
            message = "❌ Error: \(error.localizedDescription)"
        }
        
        isUploading = false
    }
}

#Preview {
    ContentView()
}
