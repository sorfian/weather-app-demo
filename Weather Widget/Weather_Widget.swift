//
//  Weather_Widget.swift
//  Weather Widget
//
//  Created by Sorfian on 13/04/23.
//

import WidgetKit
import SwiftUI
import Intents
import WeatherInfoKit

var defaults = UserDefaults(suiteName: "group.id.signal.Weather-App-Demo")!

struct Provider: IntentTimelineProvider {
    
    func placeholder(in context: Context) -> WeatherEntry {
        let weatherData = WeatherData(temperature: 0, weather: "--")
        return WeatherEntry(date: Date(), weatherData: weatherData, configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (WeatherEntry) -> ()) {
        let weatherData = WeatherData(temperature: 30, weather: "Sunny")
        let entry = WeatherEntry(date: Date(), weatherData: weatherData, configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let currentDate = Date()
        let refreshDate = Calendar.current.date(byAdding: .minute, value: 60, to: currentDate)!
        guard let city = defaults.value(forKey: "city") as? String else { return }
        
        WeatherService.sharedWeatherService().getCurrentWeather(location: city) { data in
            guard let weatherData = data else {
                return
            }
            
            let entry = WeatherEntry(date: currentDate, weatherData: weatherData, configuration: configuration)
            let timeline = Timeline(entries: [entry], policy: .after(refreshDate))
            completion(timeline)
        }
    }
}

struct WeatherEntry: TimelineEntry {
    let date: Date
    var city: String = defaults.value(forKey: "city") as? String ?? "paris"
    var weatherData: WeatherData
    let configuration: ConfigurationIntent
}

struct Weather_WidgetEntryView : View {
    var entry: Provider.Entry
    

    var body: some View {
        VStack {
            Text(entry.city.capitalized).font(.system(size: 16, weight: .black, design: .rounded)).padding(.bottom, 2)
            Text(entry.weatherData.weather.capitalized).font(.footnote).padding(.bottom, 2)
            Text("\(entry.weatherData.temperature) &#x2103;").font(.system(size: 20, weight: .black, design: .rounded))
            Text(entry.date, style: .time).font(.footnote).padding(.top, 10)
        }
    }
}

struct Weather_Widget: Widget {
    let kind: String = "Weather_Widget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            Weather_WidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Weather Widget")
        .description("This widget is designed to display the current weather information.")
    }
}

struct Weather_Widget_Previews: PreviewProvider {
    static var previews: some View {
        Weather_WidgetEntryView(entry: WeatherEntry(date: Date(), weatherData: WeatherData(temperature: 10, weather: "Cloudy"), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
