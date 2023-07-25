//
//  VitaWidget.swift
//  VitaWidget
//
//  Created by Pahala Sihombing on 18/07/23.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
}

struct VitaWidgetEntryView : View {
    
    @Environment(\.widgetFamily) var family
    
    var entry: Provider.Entry

    var body: some View {
        
        switch family {
        case .systemSmall:
            SmallWidgetView(entry : entry)
        
        case .systemMedium:
            MediumWidgetView(entry: entry)
        
        default:
            Text("Not implemented")
        }
    }
}

struct VitaWidget: Widget {
    let kind: String = "VitaWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
//            if entry.widgetFamily == .systemSmall {
//                SmallWidgetView(text: "Small Widget")
//            } else if entry.widgetFamily == .systemMedium {
//                MediumWidgetView(text: "Medium Widget")
//            }
            VitaWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Vita Widget")
        .description("Reminder from Vita-chan to eat fruits and greens")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

struct SmallWidgetView: View {
    
    var entry: Provider.Entry
    
    var body: some View {
        VStack {
            
            VStack{
                Text(entry.date, style: .time)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(Color.toHex(hexCode: "184F43"))
                ZStack {
                    Rectangle()
                        .fill(Color.white)
                        .frame(width: 78, height: 6)
                        .cornerRadius(12)
                    HStack {
                        Rectangle()
                            .fill(LinearGradient(
                                gradient: Gradient(colors: [(Color.toHex(hexCode: "F9C2CE")),(Color.toHex(hexCode: "ED476B"))]),
                                startPoint: .leading,
                                endPoint: .trailing))
                            .frame(width: 0, height: 6)
                            .cornerRadius(12)
                        Spacer()
                    }.frame(width: 78, height: 6)
                }
                Text(("Meals 🍽️") + ("   ") + ("0/3"))
                    .font(.system(size: 11, weight: .medium))
                    .foregroundColor(Color.toHex(hexCode: "184F43"))
                    .frame(width: 78, height: 6)
                
                Spacer()
            }.padding()
            Spacer()
       //            Image("VitaAngryWidget")
        }
        .background(Image("SWDefault").ignoresSafeArea())

    }
}

struct MediumWidgetView: View {
    
    var entry: Provider.Entry
    
    var body: some View {
        HStack {
            VStack{
                HStack(spacing: 4) {
                    Text("It's")
                    Text(entry.date, style: .time)
                    Spacer()
                }.frame(width: 142, height: 26)
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                    .foregroundColor(Color.toHex(hexCode: "184F43"))
                Text("Let’s eat together when the times comes! ✊🏻")
                    .font(.caption2)
                    .font(.system(size: 11, design: .rounded))
                    .foregroundColor(Color.toHex(hexCode: "184F43"))
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                    .frame(width: 142, height: 26)
//                    .multilineTextAlignment(.leading)
                    
                
                HStack {
                    HStack{
                        Text("Meals 🍽️")
                        Spacer()
                        Text("2/3")
                    }.font(.system(size: 11, weight: .medium))
                    .foregroundColor(Color.toHex(hexCode: "0E2F28"))
                    .frame(width: 103, height: 6)
                   Spacer()
                }
                HStack {
                    ZStack {
                        Rectangle()
                            .fill(Color.white)
                            .frame(width: 103, height: 6)
                            .cornerRadius(12)
                        HStack {
                            Rectangle()
                                .fill(LinearGradient(
                                    gradient: Gradient(colors: [(Color.toHex(hexCode: "F9C2CE")),(Color.toHex(hexCode: "ED476B"))]),
                                    startPoint: .leading,
                                    endPoint: .trailing))
                                .frame(width: 66, height: 6)
                                .cornerRadius(12)
                            Spacer()
                        }.frame(width: 103, height: 6)
                    }
                    Spacer()
                }
                
            }.frame(width: 142, height: 93)
            .padding()
            

            Image("VitaAngryWidget")
                .resizable()
                .hidden()
        }
        .background(Image("MWDefault").ignoresSafeArea())

    }
}

struct VitaWidget_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            VitaWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
            VitaWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
                .previewContext(WidgetPreviewContext(family: .systemMedium))
        }
    }
}




/*
 
 VStack {
     
     VStack{
         Text(entry.date, style: .time)
             .fontWeight(.semibold)
             .font(.system(size: 20))
             .foregroundColor(Color.toHex(hexCode: "184F43"))
         ZStack {
             Rectangle()
                 .fill(Color.white)
                 .frame(width: 78, height: 6)
                 .cornerRadius(12)
             HStack {
                 Rectangle()
                     .fill(LinearGradient(
                         gradient: Gradient(colors: [(Color.toHex(hexCode: "F9C2CE")),(Color.toHex(hexCode: "ED476B"))]),
                         startPoint: .leading,
                         endPoint: .trailing))
                     .frame(width: 70, height: 6)
                     .cornerRadius(12)
                 Spacer()
             }.frame(width: 78, height: 6)
         }
         Text(("Meals 🍽️") + ("   ") + ("2/3"))
             .font(.system(size: 11))
             .fontWeight(.medium)
             .foregroundColor(Color.toHex(hexCode: "0E2F28"))
         
         Spacer()
     }.padding()
     Spacer()
//            Image("VitaAngryWidget")
 }
 .background(Image("SWDefault").ignoresSafeArea())
 
 */
