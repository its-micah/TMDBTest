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
    
    
    private func loadProjectsFromDisk() -> [ResearchProject] {
        var projects: [ResearchProject] = []
        let rotlaPosterPath = "/44sKJOGP3fTm4QXBcIuqu0RkdP7.jpg"
        let ferrisPosterPath = "/kto49vDiSzooEdy4WQH2RtaC9oP.jpg"
        let thorPosterPath = "/rzRwTcFvttcN1ZpX2xv4j3tSdJu.jpg"
        let foxPosterPath = "/750pfEttsYAVmynRg2vmt1AXh4q.jpg"
        let wilderpeoplePosterPath = "/2wxvvnHKdZRB31Drf7PbRzPb0mR.jpg"
        let apesPosterPath = "/3vYhLLxrTtZLysXtIWktmd57Snv.jpg"
        
        let rotla = ResearchProject(title: "Raiders of the Lost Ark", movieID: 85, posterPath: rotlaPosterPath, notes: [String](), researchLog: ResearchLog())
        let ferris = ResearchProject(title: "Ferris Bueller's Day Off", movieID: 9377, posterPath: ferrisPosterPath, notes: [String](), researchLog: ResearchLog())
        let thorRagnarok = ResearchProject(title: "Thor: Ragnarok", movieID: 284053, posterPath: thorPosterPath, notes: [String](), researchLog: ResearchLog())
        let fantasticMrFox = ResearchProject(title: "Fantastic Mr. Fox", movieID: 10315, posterPath: foxPosterPath, notes: [String](), researchLog: ResearchLog())
        let huntForTheWilderpeople = ResearchProject(title: "Hunt for the Wilderpeople", movieID: 371645, posterPath: wilderpeoplePosterPath, notes: [String](), researchLog: ResearchLog())
        let apes = ResearchProject(title: "War for the Planet of the Apes", movieID: 281338, posterPath: apesPosterPath, notes: [String](), researchLog: ResearchLog())
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
