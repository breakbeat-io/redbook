//
//  Source+CoreDataExtensions.swift
//  redbook (iOS)
//
//  Created by Greg Hepworth on 10/03/2021.
//

import Foundation

extension Source {
    
    var sourceProviderID: String {
        providerId ?? ""
    }
    
    var sourceArtist: String {
        artist ?? "[artist missing]"
    }
    
    var sourceTitle: String {
        title ?? "[title missing]"
    }
    
    var sourceArtworkURL: URL {
        artworkURL ?? URL(string: "about:blank")!
    }
  
}
