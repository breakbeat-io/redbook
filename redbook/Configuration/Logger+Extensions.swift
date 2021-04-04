//
//  Logger+Extensions.swift
//  redbook (iOS)
//
//  Created by Greg Hepworth on 04/04/2021.
//

import os

extension Logger {
  static let action = Logger(subsystem: "io.breakbeat.redbook", category: "action")
  static let persistence = Logger(subsystem: "io.breakbeat.redbook", category: "persitence")
}
