//
//  Weather.swift
//  Test_Task_1
//
//  Created by Юрий Шелест on 18.12.22.
//

import Foundation

struct Weather {
    var name: String = "Загрузка..."
    var temperature: Double = 0.0
    var temperatureString: String {
        return String(format: "%.0f", temperature)
    }
    var conditionCode: String = ""
    var url: String = ""
    var condition: String = ""
    var presureMm: Int = 0
    var windSpeed: Double = 0.0
    var tempMin: Int = 0
    var tempMax: Int = 0
    
    var conditionalStrig: String {
        switch condition {
        case "clear" : return "Ясно"
        case "cloudy" : return "Облачно с прояснениями"
        case "light-rain" : return "Небольшой дождь"
        case "light-snow" : return "Небольшой снег"
        case "overcast" : return "Пасмурно"
        case "partly-cloudy" : return "Малооблачно"
        case "wet-snow" : return "Дождь со снегом"
        default: return "Загрузка..."
        }
    }
    
    init?(weatherData: WeatherData) {
        temperature = weatherData.fact.temp
        conditionCode = weatherData.fact.icon
        url = weatherData.info.url
        condition = weatherData.fact.condition
        presureMm = weatherData.fact.pressureMm
        windSpeed = weatherData.fact.windSpeed
        tempMin = weatherData.forecasts.first!.parts.day.tempMin!
        tempMax = weatherData.forecasts.first!.parts.day.tempMax!
        
    }
    init() {
        
    }
}
