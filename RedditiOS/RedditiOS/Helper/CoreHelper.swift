//
//  CoreHelper.swift
//  RedditiOS
//
//  Created by orpan on 28.04.2021.
//

import UIKit
import CoreData

class CoreHelper {
    
    static func savePosts(posts: [NewsForView]) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        managedContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        let entity = NSEntityDescription.entity(forEntityName: "Post", in: managedContext)!
        let post = NSManagedObject(entity: entity, insertInto: managedContext)
        for postItem in posts {
            post.setValue(postItem.author, forKey: PostEntityKeys.author.rawValue)
            post.setValue(postItem.title, forKey: PostEntityKeys.title.rawValue)
            post.setValue(postItem.newsDescription, forKey: PostEntityKeys.postDescription.rawValue)
            post.setValue(postItem.created, forKey: PostEntityKeys.created.rawValue)
            post.setValue(postItem.numberOfComments, forKey: PostEntityKeys.numberOfComments.rawValue)
            post.setValue(postItem.imageUrl, forKey: PostEntityKeys.imageUrl.rawValue)
            post.setValue(postItem.postUrl, forKey: PostEntityKeys.postUrl.rawValue)
        }
        do {
            try managedContext.save()
        }
        catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    static func fetchPosts() -> [NewsForView] {
        var lastFetchedPosts = [NewsForView]()
        guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
            return []
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        managedContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: PostEntityKeys.entityName.rawValue)
        do {
            let lastPosts = try managedContext.fetch(fetchRequest)
            for post in lastPosts {
                let title = post.value(forKey: PostEntityKeys.title.rawValue) as! String
                let descriptionPost = post.value(forKey: PostEntityKeys.postDescription.rawValue) as! String
                let author = post.value(forKey: PostEntityKeys.author.rawValue) as! String
                let imageUrl = post.value(forKey: PostEntityKeys.imageUrl.rawValue) as! String
                let created = post.value(forKey: PostEntityKeys.created.rawValue) as! Date
                let numberOfComments = post.value(forKey: PostEntityKeys.numberOfComments.rawValue) as! Int
                let postUrl = post.value(forKey: PostEntityKeys.postUrl.rawValue) as! String
                let fetchedPost = NewsForView(
                    title: title,
                    newsDescription: descriptionPost,
                    created: created,
                    author: author,
                    numberOfComments: numberOfComments,
                    imageUrl: imageUrl,
                    postUrl: postUrl)
                lastFetchedPosts.append(fetchedPost)
            }
            return lastFetchedPosts
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return []
    }
    
    static func deleteLastPosts() {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext

        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: Configuration.postEntityName)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)

        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print ("There was an error")
        }
    }
    
    enum PostEntityKeys: String {
        case entityName = "Post"
        case title = "title"
        case postDescription = "body"
        case created = "created"
        case imageUrl = "imageUrl"
        case postUrl = "postUrl"
        case author = "author"
        case numberOfComments = "numberOfComments"
    }
}


extension Array where Element: Hashable {
    func uniqued() -> [Element] {
        var set = Set<Element>()
        return filter { set.insert($0).inserted }
    }
}

