//
//  DDayDietWidgetLiveActivity.swift
//  DDayDietWidget
//
//  Created by Fenn on 2023/11/23.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct DDayDietWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct DDayDietWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: DDayDietWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension DDayDietWidgetAttributes {
    fileprivate static var preview: DDayDietWidgetAttributes {
        DDayDietWidgetAttributes(name: "World")
    }
}

extension DDayDietWidgetAttributes.ContentState {
    fileprivate static var smiley: DDayDietWidgetAttributes.ContentState {
        DDayDietWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: DDayDietWidgetAttributes.ContentState {
         DDayDietWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: DDayDietWidgetAttributes.preview) {
   DDayDietWidgetLiveActivity()
} contentStates: {
    DDayDietWidgetAttributes.ContentState.smiley
    DDayDietWidgetAttributes.ContentState.starEyes
}
