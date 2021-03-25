//
//  SourceDetail.swift
//  redbook (iOS)
//
//  Created by Greg Hepworth on 05/03/2021.
//

import os.log
import SwiftUI

struct SourceDetail: View {
  
  @EnvironmentObject var app: AppEnvironment
  
  var sourceId: String
  var showPlaybackLink: Bool
  
  var body: some View {
    
    ZStack {
      ScrollView {
        if let source = app.state.active.source {
          SourceCover(sourceName: source.title,
                      sourceArtist: source.artistName,
                      sourceArtworkURL: source.artworkURL)
            .padding(.bottom)
          
          if showPlaybackLink {
            PlaybackLink(playbackURL: source.playbackURL)
              .padding(.bottom)
          }
          TrackList(sourceTracks: source.tracks,
                    sourceArtist: source.artistName)
        }
      }
      .padding()
      
      switch app.state.active.loadStatus {
        
      case .loading:
        ActivityIndicator(style: .large)
        
      case .error:
        Text(app.state.search.searchStatus.rawValue)
          .foregroundColor(.secondary)
        
      case .idle:
        EmptyView()
        
      }
      
    }
    .onAppear() {
      app.process(ActiveAction.UpdateLoadStatus(newStatus: .loading))
      app.process(SearchAction.GetAppleMusicAlbum(sourceId: sourceId,
                                                  success: { source in
                                                    ActiveAction.LoadSource(source: source)
                                                  },
                                                  error: { error in
                                                    ActiveAction.LoadError(error: error)
                                                  }
      ))
    }
    .onDisappear {
      app.process(ActiveAction.UnloadSource())
    }
  }
}
