//
//  Logger+Extensions.swift
//  redbook (iOS)
//
//  Created by Greg Hepworth on 04/04/2021.
//

import os

extension Logger {
  static let state = Logger(subsystem: "io.breakbeat.redbook", category: "action")
  static let coredata = Logger(subsystem: "io.breakbeat.redbook", category: "coredata")
  static let cloudkit = Logger(subsystem: "io.breakbeat.redbook", category: "cloudkit")
  static let action = Logger(subsystem: "io.breakbeat.redbook", category: "action")
}
