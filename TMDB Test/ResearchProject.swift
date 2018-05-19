//
//  ResearchProject.swift
//  TMDB Test
//
//  Created by Micah Lanier on 3/21/18.
//  Copyright © 2018 Micah Lanier. All rights reserved.
//

import Foundation
import TMDBSwift


class ResearchProject {
    let title: String
    let movieID: Int
    let posterPath: String?
    let backdropPath: String?
    var notes: Array<String>
    let researchLog: ResearchLog
    let director: String?
    let writer: String?
    let runtime: String?
    let year: String?
    
    init(title: String, movieID: Int, posterPath: String?, backdropPath: String?, notes: Array<String>, researchLog: ResearchLog, director: String?, writer: String?, runtime: String?, year: String?) {
        self.title = title
        self.movieID = movieID
        self.posterPath = posterPath
        self.backdropPath = backdropPath
        self.notes = notes
        self.researchLog = researchLog
        self.director = director
        self.writer = writer
        self.runtime = runtime
        self.year = year
    }
    
    func makePosterURL(_ path: String?) -> URL? {
        guard let actualPath = path else {
            return nil
        }
        return URL(string: baseURL + posterSize + actualPath)
    }
    
    func makeBackdropURL(_ path: String?) -> URL? {
        guard let actualPath = path else {
            return nil
        }
        return URL(string: baseURL + backdropSize + actualPath)
    }
}

struct Event {
    var description: String
    var timestamp: String?
}

final class ResearchLog {
    var logItems: Array<Event> = [Event]()
    
    func orderedEvents() -> [Event] {
        let nonNilArray = logItems.filter { $0.timestamp != nil }
        return nonNilArray.sorted { $0.timestamp!.compare($1.timestamp!, options: .numeric) == .orderedAscending }
    }
    
    func unorderedEvents() -> [Event] {
        let nilTimestamps = logItems.filter { $0.timestamp == nil }
        return nilTimestamps
    }
    
    func entireLog() -> [Event] {
        return self.orderedEvents() + self.unorderedEvents()
    }
    
    func add(_ item: Event) {
        self.logItems.append(item)
    }
    
    func updateEvent(_ event: Event, atIndex index: Int) {
        self.logItems.remove(at: index)
        self.add(event)
    }
}
