//
//  ProjectsDataSource.swift
//  TMDB Test
//
//  Created by Micah Lanier on 3/28/18.
//  Copyright © 2018 Micah Lanier. All rights reserved.
//

import Foundation
import UIKit

let APIKey = "129c600b875d890d125e8dfda77bb60c"
let baseURL = "https://image.tmdb.org/t/p/"
let posterSize = "w342"
let projectPosterSize = "w342"
let backdropSize = "w500"

class ProjectsDataSource {
    private var projects = [ResearchProject]()
    
    var count: Int {
        return projects.count
    }
    
    init() {
        projects = loadProjectsFromDisk()
    }
    
    func moveProjectAtIndexPath(_ indexPath: IndexPath, toIndexPath newIndexPath: IndexPath) {
        if indexPath == newIndexPath {
            return
        }
        
        let index = absoluteIndexForIndexPath(indexPath)
        let project = projects[index]
        let newIndex = absoluteIndexForIndexPath(newIndexPath)
        projects.remove(at: index)
        projects.insert(project, at: newIndex)
    }
    
    func numberOfProjectsInSection() -> Int {
        return projects.count
    }
    
    func projectForItemAtIndexPath(_ indexPath: IndexPath) -> ResearchProject? {
        return projects[indexPath.item]
    }
    
    func addNewProject(_ project: ResearchProject) {
        projects.insert(project, at: 0)
    }
    
    func removeProject(at int: Int) {
        projects.remove(at: int)
    }
    
    
    private func loadProjectsFromDisk() -> [ResearchProject] {
        var projects: [ResearchProject] = []
        let rotlaPosterPath = "/44sKJOGP3fTm4QXBcIuqu0RkdP7.jpg"
        let ferrisPosterPath = "/kto49vDiSzooEdy4WQH2RtaC9oP.jpg"
        let thorPosterPath = "/rzRwTcFvttcN1ZpX2xv4j3tSdJu.jpg"
        let foxPosterPath = "/750pfEttsYAVmynRg2vmt1AXh4q.jpg"
        let wilderpeoplePosterPath = "/2wxvvnHKdZRB31Drf7PbRzPb0mR.jpg"
        let apesPosterPath = "/3vYhLLxrTtZLysXtIWktmd57Snv.jpg"
        
        let rotlaBackdropPath = "/1TxaXNobCO3fhcgYUfLHj6CkEFP.jpg"
        let ferrisBackdropPath = "/kto49vDiSzooEdy4WQH2RtaC9oP.jpg"
        let thorBackdropPath = "/kaIfm5ryEOwYg8mLbq8HkPuM1Fo.jpg"
        let foxBackdropPath = "/750pfEttsYAVmynRg2vmt1AXh4q.jpg"
        let wilderpeopleBackdropPath = "/2wxvvnHKdZRB31Drf7PbRzPb0mR.jpg"
        let apesBackdropPath = "/3vYhLLxrTtZLysXtIWktmd57Snv.jpg"
        
        let rotla = ResearchProject(title: "Raiders of the Lost Ark", movieID: 85, posterPath: rotlaPosterPath, backdropPath: rotlaBackdropPath, notes: [String](), researchLog: ResearchLog(), director: "Steven Spielberg", writer: "Lawrence Kasdan", runtime: "115 mins", year: "1981")
        let ferris = ResearchProject(title: "Ferris Bueller's Day Off", movieID: 9377, posterPath: ferrisPosterPath, backdropPath: ferrisBackdropPath, notes: [String](), researchLog: ResearchLog(), director: "John Hughes", writer: "John Hughes", runtime: "103 mins", year: "103 mins")
        let thorRagnarok = ResearchProject(title: "Thor: Ragnarok", movieID: 284053, posterPath: thorPosterPath, backdropPath: thorBackdropPath, notes: [String](), researchLog: ResearchLog(), director: "Taika Watiti", writer: "Craig Kyle, Christopher Yost, Eric Pearson", runtime: "130 mins", year: "2017")
        let fantasticMrFox = ResearchProject(title: "Fantastic Mr. Fox", movieID: 10315, posterPath: foxPosterPath, backdropPath: foxBackdropPath, notes: [String](), researchLog: ResearchLog(), director: "Wes Anderson", writer: "Noah Baumbach", runtime: "87 mins", year: "2009")
        let huntForTheWilderpeople = ResearchProject(title: "Hunt for the Wilderpeople", movieID: 371645, posterPath: wilderpeoplePosterPath, backdropPath: wilderpeopleBackdropPath, notes: [String](), researchLog: ResearchLog(), director: "Taika Watiti", writer: "Taika Watiti", runtime: "101 mins", year: "2016")
        let apes = ResearchProject(title: "War for the Planet of the Apes", movieID: 281338, posterPath: apesPosterPath, backdropPath: apesBackdropPath, notes: [String](), researchLog: ResearchLog(), director: "Matt Reeves", writer: "Mark Bomback, Matt Reeves", runtime: "140 mins", year: "2017")
        projects = [rotla, ferris, thorRagnarok, fantasticMrFox, huntForTheWilderpeople, apes]
        return projects
    }
    
    private func absoluteIndexForIndexPath(_ indexPath: IndexPath) -> Int {
        var index = 0
        for _ in 0..<indexPath.section {
            index += projects.count
        }
        index += indexPath.item
        return index
    }
    
}
