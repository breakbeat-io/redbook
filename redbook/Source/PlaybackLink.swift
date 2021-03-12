//
//  PlaybackLink.swift
//  redbook (iOS)
//
//  Created by Greg Hepworth on 10/03/2021.
//

import SwiftUI

struct PlaybackLink: View {
  
  let playbackURL: URL
  
  var body: some View {
    Button {
      UIApplication.shared.open(playbackURL)
    } label: {
      HStack {
        Image(systemName: "play.fill")
          .font(.headline)
        Text("Play in Apple Music")
          .font(.headline)
      }
      .padding()
      .foregroundColor(.primary)
      .cornerRadius(40)
      .overlay(
        RoundedRectangle(cornerRadius: 40)
          .stroke(Color.primary, lineWidth: 2)
      )
    }
  }
}
