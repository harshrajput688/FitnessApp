//
//  HKWorkOutActivityType.swift
//  FitnessApp
//
//  Created by Harsh Rajput on 08/02/25.
//

import Foundation
import SwiftUI
import HealthKit
extension HKWorkoutActivityType {

    /*
     Simple mapping of available workout types to a human readable name.
     */
    var name: String {
        switch self {
        case .americanFootball:             return "American Football"
        case .archery:                      return "Archery"
        case .australianFootball:           return "Australian Football"
        case .badminton:                    return "Badminton"
        case .baseball:                     return "Baseball"
        case .basketball:                   return "Basketball"
        case .bowling:                      return "Bowling"
        case .boxing:                       return "Boxing"
        case .climbing:                     return "Climbing"
        case .crossTraining:                return "Cross Training"
        case .curling:                      return "Curling"
        case .cycling:                      return "Cycling"
        case .dance:                        return "Dance"
        case .danceInspiredTraining:        return "Dance Inspired Training"
        case .elliptical:                   return "Elliptical"
        case .equestrianSports:             return "Equestrian Sports"
        case .fencing:                      return "Fencing"
        case .fishing:                      return "Fishing"
        case .functionalStrengthTraining:   return "Functional Strength Training"
        case .golf:                         return "Golf"
        case .gymnastics:                   return "Gymnastics"
        case .handball:                     return "Handball"
        case .hiking:                       return "Hiking"
        case .hockey:                       return "Hockey"
        case .hunting:                      return "Hunting"
        case .lacrosse:                     return "Lacrosse"
        case .martialArts:                  return "Martial Arts"
        case .mindAndBody:                  return "Mind and Body"
        case .mixedMetabolicCardioTraining: return "Mixed Metabolic Cardio Training"
        case .paddleSports:                 return "Paddle Sports"
        case .play:                         return "Play"
        case .preparationAndRecovery:       return "Preparation and Recovery"
        case .racquetball:                  return "Racquetball"
        case .rowing:                       return "Rowing"
        case .rugby:                        return "Rugby"
        case .running:                      return "Running"
        case .sailing:                      return "Sailing"
        case .skatingSports:                return "Skating Sports"
        case .snowSports:                   return "Snow Sports"
        case .soccer:                       return "Soccer"
        case .softball:                     return "Softball"
        case .squash:                       return "Squash"
        case .stairClimbing:                return "Stair Climbing"
        case .surfingSports:                return "Surfing Sports"
        case .swimming:                     return "Swimming"
        case .tableTennis:                  return "Table Tennis"
        case .tennis:                       return "Tennis"
        case .trackAndField:                return "Track and Field"
        case .traditionalStrengthTraining:  return "Traditional Strength Training"
        case .volleyball:                   return "Volleyball"
        case .walking:                      return "Walking"
        case .waterFitness:                 return "Water Fitness"
        case .waterPolo:                    return "Water Polo"
        case .waterSports:                  return "Water Sports"
        case .wrestling:                    return "Wrestling"
        case .yoga:                         return "Yoga"

        // iOS 10
        case .barre:                        return "Barre"
        case .coreTraining:                 return "Core Training"
        case .crossCountrySkiing:           return "Cross Country Skiing"
        case .downhillSkiing:               return "Downhill Skiing"
        case .flexibility:                  return "Flexibility"
        case .highIntensityIntervalTraining:    return "High Intensity Interval Training"
        case .jumpRope:                     return "Jump Rope"
        case .kickboxing:                   return "Kickboxing"
        case .pilates:                      return "Pilates"
        case .snowboarding:                 return "Snowboarding"
        case .stairs:                       return "Stairs"
        case .stepTraining:                 return "Step Training"
        case .wheelchairWalkPace:           return "Wheelchair Walk Pace"
        case .wheelchairRunPace:            return "Wheelchair Run Pace"

        // iOS 11
        case .taiChi:                       return "Tai Chi"
        case .mixedCardio:                  return "Mixed Cardio"
        case .handCycling:                  return "Hand Cycling"

        // iOS 13
        case .discSports:                   return "Disc Sports"
        case .fitnessGaming:                return "Fitness Gaming"

        // Catch-all
        default:                            return "Other"
        }
        
        }
    var image: String {
        switch self {
        case .americanFootball: return "football.fill"
        case .archery: return "target"
        case .australianFootball: return "sportscourt"
        case .badminton: return "figure.badminton"
        case .baseball: return "baseball.fill"
        case .basketball: return "basketball.fill"
        case .bowling: return "bowling.ball.fill"
        case .boxing: return "figure.boxing"
        case .climbing: return "figure.climbing"
        case .crossTraining: return "figure.strengthtraining.traditional"
        case .curling: return "sportscourt"
        case .cycling: return "bicycle"
        case .dance: return "figure.dance"
        case .danceInspiredTraining: return "figure.cooldown"
        case .elliptical: return "figure.elliptical"
        case .equestrianSports: return "horse.fill"
        case .fencing: return "sportscourt"
        case .fishing: return "fish.fill"
        case .functionalStrengthTraining: return "figure.strengthtraining.functional"
        case .golf: return "figure.golf"
        case .gymnastics: return "sportscourt"
        case .handball: return "sportscourt"
        case .hiking: return "figure.hiking"
        case .hockey: return "hockey.puck"
        case .hunting: return "binoculars.fill"
        case .lacrosse: return "sportscourt"
        case .martialArts: return "figure.martial.arts"
        case .mindAndBody: return "figure.mind.and.body"
        case .mixedMetabolicCardioTraining: return "figure.strengthtraining.traditional"
        case .paddleSports: return "figure.rower"
        case .play: return "gamecontroller.fill"
        case .preparationAndRecovery: return "figure.cooldown"
        case .racquetball: return "sportscourt"
        case .rowing: return "figure.rower"
        case .rugby: return "sportscourt"
        case .running: return "figure.run"
        case .sailing: return "sailboat.fill"
        case .skatingSports: return "figure.skating"
        case .snowSports: return "snowflake"
        case .soccer: return "soccerball"
        case .softball: return "softball.fill"
        case .squash: return "sportscourt"
        case .stairClimbing: return "figure.stair.stepper"
        case .surfingSports: return "figure.surfing"
        case .swimming: return "figure.pool.swim"
        case .tableTennis: return "tabletennis"
        case .tennis: return "tennisball.fill"
        case .trackAndField: return "sportscourt"
        case .traditionalStrengthTraining: return "figure.strengthtraining.traditional"
        case .volleyball: return "volleyball.fill"
        case .walking: return "figure.walk"
        case .waterFitness: return "figure.pool.swim"
        case .waterPolo: return "figure.waterpolo"
        case .waterSports: return "figure.surfing"
        case .wrestling: return "figure.wrestling"
        case .yoga: return "figure.yoga"
        case .barre: return "figure.barre"
        case .coreTraining: return "figure.core.training"
        case .crossCountrySkiing: return "figure.cross.country.skiing"
        case .downhillSkiing: return "figure.skiing.downhill"
        case .flexibility: return "figure.cooldown"
        case .highIntensityIntervalTraining: return "figure.highintensity.intervaltraining"
        case .jumpRope: return "figure.jumprope"
        case .kickboxing: return "figure.kickboxing"
        case .pilates: return "figure.pilates"
        case .snowboarding: return "figure.snowboarding"
        case .stairs: return "figure.stairs"
        case .stepTraining: return "figure.step.training"
        case .wheelchairWalkPace: return "figure.roll.walk"
        case .wheelchairRunPace: return "figure.roll.run"
        case .taiChi: return "figure.taichi"
        case .mixedCardio: return "figure.mixed.cardio"
        case .handCycling: return "figure.hand.cycling"
        case .discSports: return "sportscourt"
        case .fitnessGaming: return "gamecontroller.fill"
        default: return "person"
        }
    }

    var color: Color {
        switch self {
        case .americanFootball: return .brown
        case .archery: return .blue
        case .australianFootball: return .orange
        case .badminton: return .yellow
        case .baseball: return .red
        case .basketball: return .orange
        case .bowling: return .purple
        case .boxing: return .red
        case .climbing: return .gray
        case .crossTraining: return .pink
        case .curling: return .green
        case .cycling: return .blue
        case .dance: return .purple
        case .danceInspiredTraining: return .pink
        case .elliptical: return .gray
        case .equestrianSports: return .brown
        case .fencing: return .gray
        case .fishing: return .blue
        case .functionalStrengthTraining: return .red
        case .golf: return .green
        case .gymnastics: return .blue
        case .handball: return .yellow
        case .hiking: return .green
        case .hockey: return .blue
        case .hunting: return .brown
        case .lacrosse: return .orange
        case .martialArts: return .red
        case .mindAndBody: return .blue
        case .mixedMetabolicCardioTraining: return .purple
        case .paddleSports: return .blue
        case .play: return .yellow
        case .preparationAndRecovery: return .pink
        case .racquetball: return .blue
        case .rowing: return .blue
        case .rugby: return .green
        case .running: return .red
        case .sailing: return .blue
        case .skatingSports: return .gray
        case .snowSports: return .white
        case .soccer: return .green
        case .softball: return .yellow
        case .squash: return .orange
        case .stairClimbing: return .gray
        case .surfingSports: return .blue
        case .swimming: return .cyan
        case .tableTennis: return .orange
        case .tennis: return .green
        case .volleyball: return .yellow
        default: return .gray
        }
    }

}
