//
//  LockScreenWidget.swift
//  LockScreenWidget
//
//  Created by Jonas Vetsch on 06.10.2024.
//

import WidgetKit
import SwiftUI

struct SimpleEntry: TimelineEntry {
  let date: Date
}

struct Provider: TimelineProvider {
  func placeholder(in context: Context) -> SimpleEntry {
    SimpleEntry(date: Date())
  }
  
  func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
    let entry = SimpleEntry(date: Date())
    completion(entry)
  }
  
  func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> ()) {
    let entries = [SimpleEntry(date: Date())]
    let timeline = Timeline(entries: entries, policy: .atEnd)
    completion(timeline)
  }
}

// ADJUST THE VIEW HERE
struct LockScreenWidgetEntryView: View {
  var entry: Provider.Entry
  
  var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: 100)
        .opacity(0.2)
        .frame(width: 59, height: 59)
      Image(.lockScreenWidget)
        .scaleEffect(0.9)
    }
  }
}

@main
struct LockScreenWidget: Widget {
  let kind: String = "LockScreenWidget"
  
  var body: some WidgetConfiguration {
    StaticConfiguration(kind: kind, provider: Provider()) { entry in
      LockScreenWidgetEntryView(entry: entry)
        .containerBackground(.fill.tertiary, for: .widget)
    }
    .configurationDisplayName("Quick Access")
    .description("Launch SkySolve from the lock screen")
    .supportedFamilies([.accessoryCircular])
  }
}

#Preview(as: .accessoryCircular) {
  LockScreenWidget()
} timeline: {
  SimpleEntry(date: .now)
}
