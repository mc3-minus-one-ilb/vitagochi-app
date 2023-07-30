//
//  VitaWidget.swift
//  VitaWidget
//
//  Created by Pahala Sihombing on 18/07/23.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        let mealCount = (try? getData()) ?? nil
        return SimpleEntry(date: Date(), challange: mealCount, timePhase: .morning)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        do {
            let meals = try getData()
            let entry = SimpleEntry(date: Date(), challange: meals, timePhase: .morning)
            completion(entry)
        } catch {
            print(error)
        }
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
//        var entries: [SimpleEntry] = []
//
//        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
//        let currentDate = Date()
//        for hourOffset in 0 ..< 5 {
//            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
//            let entry = SimpleEntry(date: entryDate, mealCount: me)
//            entries.append(entry)
//        }
        do {
            var entries: [SimpleEntry] = []
            let challange = try getData()
//            let entry = SimpleEntry(date: Date(), mealCount: items?.count ?? 0)
            let endDate = Calendar.current.date(byAdding: .day, value: 1, to: Date())!
            
            for timePhase in VitaWidgetTimePhase.allCases {
                let entryDate = Date().makeDateFromTimePhase(timePhase)
                let entry = SimpleEntry(date: entryDate, challange: challange, timePhase: timePhase)
                entries.append(entry)
                if timePhase == .morning || timePhase == .afternoon || timePhase == .evening {
                    let entryDate = Date().makeDateFromTimePhasePlusHour(timePhase)
                    let entry = SimpleEntry(date: entryDate, challange: challange ?? nil, timePhase: timePhase, isPassOneHour: true)
                    entries.append(entry)
                }
            }
            
            let timeline = Timeline(entries: entries, policy: .after(endDate))
            completion(timeline)
        } catch {
            print(error)
        }
    }
    
    private func getData() throws -> ChallangeEntity? {
        let coreData = CoreDataEnvirontment()
        return coreData.todayChallange
    }
    
//    private func getTimeFromUserDefault(phase: VitaWidgetTimePhase) -> HourAndMinute {
//        let globalEnv = GlobalEnvirontment.singleton
//        if phase == .morning {
//            return globalEnv.breakfastReminder
//        } else if phase == .afternoon {
//            return globalEnv.lunchReminder
//        } else {
//            return globalEnv.dinnerReminder
//        }
//    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let challange: ChallangeEntity?
    let timePhase: VitaWidgetTimePhase
    var isPassOneHour: Bool = false
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
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
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
    var mealCount: Int
    var isComplete: Bool = false
    var smallMessage: String = ""
    var mood: VitaWidgetMood = .idle
    
    init(entry: Provider.Entry) {
        self.entry = entry
        self.mealCount = entry.challange?.records?.count ?? 0
            if let records = entry.challange?.records?.allObjects as? [MealRecordEntity] {
                for record in records {
                    if record.timeStatus == entry.timePhase.rawValue {
                        self.isComplete = true
                        break
                    }
                }
            }
        if isComplete {
            self.smallMessage = "Excelent"
            self.mood = .happy
        } else {
            if entry.isPassOneHour {
                self.smallMessage = "Don't Forget!"
                self.mood = .angry
            } else {
                self.smallMessage = entry.timePhase.titleIdleText
            }
        }
        if entry.timePhase == .afterDay {
            if mealCount == 3 {
                self.smallMessage = "You Did It! 🎉"
                self.mood = .happy
            } else if mealCount == 2 {
                self.smallMessage = "Well Done!"
                self.mood = .idle
            } else if mealCount == 1 {
                self.smallMessage = "Not Bad!"
                self.mood = .idle
            } else {
                self.smallMessage = "Huft, Too Bad ..."
                self.mood = .angry
            }
        }
    }
    
    var body: some View {
        VStack {
            VStack{
                Text(smallMessage)
                    .font(.system(size: 15, weight: .semibold, design: .rounded))
//                    .fontDesign(.rounded)
                    .kerning(-0.4)
                    .foregroundColor(.widgetFontColor)
                ProgressView(value: CGFloat(mealCount), total: 3, label:  {
                    Text("Meals\(entry.timePhase.mealTimeIcon)")
                        .font(.system(size: 11, weight: .medium, design: .rounded))
//                        .fontDesign(.rounded)
                        .kerning(-0.4)
                        .foregroundColor(.widgetDarkerFontColor)
                }, currentValueLabel:  {
                    Text("\(mealCount)/3")
                        .font(.system(size: 11, weight: .medium, design: .rounded))
//                        .fontDesign(.rounded)
                        .foregroundColor(.widgetDarkerFontColor)
                        
                }).progressViewStyle(WidgetSmallMealProgressStyle(height: 8))
                    .padding(.horizontal)
                
                
//                ZStack {
//                    Rectangle()
//                        .fill(Color.white)
//                        .frame(width: 78, height: 6)
//                        .cornerRadius(12)
//                    HStack {
//                        Rectangle()
//                            .fill(LinearGradient(
//                                gradient: Gradient(colors: [(Color.toHex(hexCode: "F9C2CE")),(Color.toHex(hexCode: "ED476B"))]),
//                                startPoint: .leading,
//                                endPoint: .trailing))
//                            .frame(width: 0, height: 6)
//                            .cornerRadius(12)
//                        Spacer()
//                    }.frame(width: 78, height: 6)
//                }
//                Text(("Meals 🍽️") + ("   ") + ("\(entry.mealCount)/3"))
//                    .font(.system(size: 11, weight: .medium))
//                    .foregroundColor(Color.toHex(hexCode: "184F43"))
//                    .frame(width: 78, height: 6)
                
                
            }.padding()
            Spacer()
       //            Image("VitaAngryWidget")
        }
        .background(Image(mood.image).ignoresSafeArea())

    }
}

struct MediumWidgetView: View {
    
    var entry: Provider.Entry
    var mealCount: Int = 0
    var isComplete: Bool = false
    var mediumMessage: String = "Let’s eat together when the times comes! ✊🏻"
    var mediumTitle: String = "It’s a New Day"
    var mood: VitaWidgetMood = .idle
    
    init(entry: Provider.Entry) {
        self.entry = entry
        self.mealCount = entry.challange?.records?.count ?? 0
            if let records = entry.challange?.records?.allObjects as? [MealRecordEntity] {
                for record in records {
                    if record.timeStatus == entry.timePhase.rawValue {
                        self.isComplete = true
                        break
                    }
                }
            }
        if isComplete {
            self.mediumTitle = "Way to Go, Buddy!"
            self.mood = .happy
        } else {
            if entry.isPassOneHour {
                self.mediumTitle = "Did You Forget?"
                self.mood = .angry
                
            } else {
                self.mediumTitle = entry.timePhase.titleIdleText
            }
        }
        self.mediumMessage = mood.mediumMessage(phase: entry.timePhase)
        if entry.timePhase == .afterDay {
            if mealCount == 3 {
                self.mediumTitle = "You Did It! 🎉"
                self.mediumMessage = "Excellent! Way to Go to be a healthier version of you! 🥰"
                self.mood = .happy
            } else if mealCount == 2 {
                self.mediumTitle = "Well Done!"
                self.mediumMessage = "Cool! Just a ‘lil bit more step to have better dietary habit ☺️"
                self.mood = .idle
            } else if mealCount == 1 {
                self.mediumTitle = "Not Bad!"
                self.mediumMessage = "Please do better in eating healthy food for tomorrow 😉"
                self.mood = .idle
            } else {
                self.mediumTitle = "Huft, Too Bad ..."
                self.mediumMessage = "You can be sick if for a whole day you didn’t eat any food"
                self.mood = .angry
            }
        }
        
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading){
                Group {
                    Text(mediumTitle)
                        .font(.system(size: 15, weight: .semibold, design: .rounded))
//                        .fontDesign(.rounded)
                        .kerning(-0.4)
                        .foregroundColor(.widgetFontColor)
                    HStack {
                        Text(mediumMessage)
                            .font(.system(size: 10, weight: .regular, design: .rounded))
//                            .fontDesign(.rounded)
//                            .fontWeight(.regular)
                            .foregroundColor(.widgetFontColor)
                            .multilineTextAlignment(.leading)
                            .lineLimit(2)
                        Spacer()
                    }
                    .offset(y: -10)
                    .frame(width: 150, height: 26)
                }
                .offset(y: 5)
               
//                    .multilineTextAlignment(.leading)
                ProgressView(value: CGFloat(mealCount), total: 3, label:  {
                    Text("Meals\(entry.timePhase.mealTimeIcon)")
                        .font(.system(size: 11, weight: .medium, design: .rounded))
//                        .fontDesign(.rounded)
                        .kerning(-0.4)
                        .foregroundColor(.widgetDarkerFontColor)
                }, currentValueLabel:  {
                    Text("\(mealCount)/3")
                        .font(.system(size: 11, weight: .medium, design: .rounded))
//                        .fontDesign(.rounded)
                        .foregroundColor(.widgetDarkerFontColor)
                        
                }).progressViewStyle(WidgetMediumMealProgressStyle(height: 6))
                    .padding(.trailing)
                
//                HStack {
//                    HStack{
//                        Text("Meals 🍽️")
//                        Spacer()
//                        Text("2/3")
//                    }.font(.system(size: 11, weight: .medium))
//                    .foregroundColor(Color.toHex(hexCode: "0E2F28"))
//                    .frame(width: 103, height: 6)
//                   Spacer()
//                }
//                HStack {
//                    ZStack {
//                        Rectangle()
//                            .fill(Color.white)
//                            .frame(width: 103, height: 6)
//                            .cornerRadius(12)
//                        HStack {
//                            Rectangle()
//                                .fill(LinearGradient(
//                                    gradient: Gradient(colors: [(Color.toHex(hexCode: "F9C2CE")),(Color.toHex(hexCode: "ED476B"))]),
//                                    startPoint: .leading,
//                                    endPoint: .trailing))
//                                .frame(width: 66, height: 6)
//                                .cornerRadius(12)
//                            Spacer()
//                        }.frame(width: 103, height: 6)
//                    }
//                    Spacer()
//                }
                
            }.frame(width: 142, height: 93)
            .padding()
            .padding(.leading, 12)
            

            Image("VitaAngryWidget")
                .resizable()
                .hidden()
        }
        .background(Image(mood.imageMedium).ignoresSafeArea())

    }
}

struct VitaWidget_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            VitaWidgetEntryView(entry: SimpleEntry(date: Date(), challange: nil, timePhase: .morning))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
            VitaWidgetEntryView(entry: SimpleEntry(date: Date(), challange: nil, timePhase: .morning))
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
