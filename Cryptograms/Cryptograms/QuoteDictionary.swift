//
//  QuoteDictionary.swift
//  Swift Test 2
//
//  Created by Daniel Katz on 3/13/16.
//  Copyright © 2016 OK. All rights reserved.
//

import UIKit

class QuoteDictionary: NSObject {

    var seed: Int
    
    init(seed: Int)
    {
        self.seed = seed
    }


 //   let quoteList =
    let quoteList: [Int: Array<String>] =
        
        [
             0: ["movies", "Jaws", "You're gonna need a bigger boat"]
            ,1: ["movies", "The Perks of Being a Wallflower", "Things change. And friends leave. Life doesn't stop for anybody."]
            ,2: ["movies", "The Green Mile", "Please boss, don't put that thing over my face, don't put me in the dark. I's afraid of the dark."]
            ,3: ["movies", "Cast Away", "I'm sorry, Wilson. Wilson, I'm sorry! I'm sorry!"]
            ,4: ["movies","The Lion King", "Dad, Dad, come on, you gotta get up. Dad, we gotta go home."]
            ,5: ["movies","Toy Story 2", "You never forget kids like Emily, or Andy, but they forget you."]
            ,6: ["tv", "TV Show", "TV Quote One"]
            ,7: ["puns", "Pun source", "punText"]
            ,8: ["Movies", "True Grit (2012)", "Time just gets away from us."]
            ,9: ["Movies", "The Dark Knight Rises", "I'm so sorry. I failed you. You trusted me and I failed you."]
            ,10:["Movies", "The Land Before Time", "Littlefoot let your heart guide you. It whispers so listen closely."]
            ,11:["Movies", "I Am Legend", "I promised a friend I would say hello to you today. Please say hello to me. Please say hello to me."]
            ,12:["Movies", "Fargo (1996)", "And I guess that was your accomplice in the wood chipper."]
            ,13:["Movies", "The Hours (2002)", "Someone has to die in order that the rest of us should value life more. It's contrast."]
            ,14:["Movies", "Goldfinger (1964)", "No Mr. Bond. I expect you to die!"]
            ,15:["Movies", "Psycho (1960)", "We all go a little mad sometimes."]
            ,16:["Movies", "Rambo", "Live for nothing or die for something."]
            ,17:["Movies", "Alice In Wonderland", "I can't go back to yesterday because I was a different person then."]
            ,18:["Movies", "Mulan", "You're at peace because you know it's okay to be afraid."]
            ,19:["Movies", "Alice In Wonderland", "If you don't think then you shouldn't talk."]
            ,20:["Movies", "Deep Blue Sea", "Nature can be lethal. But it doesn't hold a candle to man."]
            ,21:["Movies", "Star Wars Episode I", "The ability to speak does not make you intelligent."]
            ,22:["Movies", "Fight Club", "This is your life and it's ending one second at a time."]
            ,23:["Movies", "Fight Club", "When the fight was over nothing was solved but nothing mattered. We all felt saved."]
            ,24:["Movies", "Futurama", "The concept of wuv confuses and infuriates us!"]
            ,25:["Movies", "Ratatouille", "Your only limit is your soul."]
            ,26:["Movies", "Harry Potter", "Do not pity the dead Harry. Pity the living and above all those who live without love."]
            ,27:["Movies", "The Simpsons", "You tried your best and you failed miserably. The lesson is never try."]
            ,28:["Movies", "The Royal Tenenbaums (2001)", "I want to make this family love me. How much money you got?"]
            ,29:["Movies", "One Hour Photo (2002)", "Nobody takes a picture of something they want to forget"]
            ,30:["Movies", "Fight Club (1999)", "You are not special. You are not a beautiful or unique snowflake. You are the same decaying organic matter as everything else."]
            ,31:["Movies", "It's a Wonderful Life (1946)", "You're worth more dead than alive!"]
            ,32:["Movies", "Rocky IV", "If he dies he dies."]
            ,33:["Movies", "It", "I'm every nightmare you've ever had. I'm your worst dream come true. I'm everything you ever were afraid of."]
            ,34:["Movies", "Aladdin", "Now where were we? Ah yes abject humiliation!"]
            ,35:["Movies", "Once Upon A Time In The West", "People scare better when they're dying."]
            ,36:["Movies", "Pan's Labyrinth", "You'd do better to tell us everything. But to make sure it happens I brought along a few tools."]
            ,37:["Movies", "There Will Be Blood", "I have a competition in me. I want no one else to succeed. I hate most people."]
            ,38:["Movies", "The Shawshank Redemption", "Get busy living or get busy dying."]
            ,39:["Movies", "Melancholia", "Life is only on earth and not for long."]
            ,40:["Movies", "The Lion King", "Bad things happen and you can't do anything about it."]
            ,41:["Movies", "Toy Story", "You're a sad strange little man and you have my pity."]
            ,42:["Movies", "Lilo and Stitch", "But if you want to leave you can. I'll remeber you though. I remember everyone that leaves."]
            ,43:["Movies", "The Lion King", "You said you'd always be there for me! But you're not."]
            ,44:["Movies", "The Little Mermaid", "The human world is a mess."]
            ,45:["Movies", "Boyhood", "I just thought there'd be more you know?"]
            ,46:["Movies", "The Matrix", "You've been living in a dream world Neo."]
            ,47:["Movies", "Donnie Darko", "Some people are just born with tragedy in their blood."]
            ,48:["Movies", "Donnie Darko", "Every creature on this earth dies alone."]
            ,49:["Movies", "Donnie Darko", "You are a fear prisoner. Yes you are a product of fear."]
            ,50:["Movies", "Donnie Darko", "If the sky were to suddenly open up there would be no law there would be no rule. There would only be you and your memories."]
            ,51:["Movies", "Whiplash", "There are no two words in the English language more harmful than good job."]
            ,52:["Movies", "Whiplash", "If you don't have ability you wind up playing in a rock band."]
            ,53:["Movies", "Breaking Bad", "I've still got things left to do."]
            ,54:["Movies", "Midnight in Paris", "That's what the present is. It's a little unsatisfying because life is unsatisfying."]
            ,55:["Movies", "Se7en", "Ernest Hemingway once wrote the world is a fine place and worth fighting for. I agree with the second part."]
            ,56:["Movies", "A Beautiful Mind", "Imagine if you suddenly learned that the people the places the moments most important to you were not gone not dead but worse had never been. What kind of hell would that be?"]
            ,57:["Movies", "A Beautiful Mind", "Classes will dull your mind destroy the potential for authentic creativity."]
            ,58:["Movies", "A Beautiful Mind", "They are my past. Everyone is haunted by their past."]
            ,59:["Movies", "Lost in Translation", "I tried taking pictures but they were so mediocre."]
            ,60:["Movies", "Lost in Translation", "Why do you have to point out how stupid everyone is all the time?"]
            ,61:["Movies", "The Dark Knight", "You either die a hero or you live long enough to see yourself become the villain."]
            ,62:["Movies", "The Dark Knight", "You thought we could be decent men in an indecent time. But you were wrong. The world is cruel and the only morality in a cruel world is chance."]
            ,63:["Movies", "The Dark Knight", "You have nothing nothing to threaten me with. Nothing to do with all your strength."]
            ,64:["Movies", "The Truman Show", "Oh you're too late. There's really nothing left to explore."]
            ,65:["Movies", "Saw II", "Once you're in hell only the devil can help you out."]
            ,66:["Movies", "Saw VI", "Until a person is faced with death it's impossible to tell whether they have what it takes to survive."]
            ,67:["Movies", "Super", "People look stupid when they cry."]
            ,68:["Movies", "Dune", "Fear is the little death that brings total obliteration"]
            ,69:["Movies", "Dune", "Without change something sleeps inside of us and seldom awakens."]
            ,70:["Movies", "Dune", "I'm dead to everyone unless I become what I may be."]
            ,71:["Movies", "Taxi Driver", "Loneliness has followed me my whole life everywhere. In bars in cars sidewalks stores everywhere. There's no escape. I'm God's lonely man."]
            ,72:["Movies", "Taxi Driver", "I once had a horse on Coney Island. She got hit by a car."]
            ,73:["Movies", "Taxi Driver", "Twelve hours of work and I still can't sleep."]
            ,74:["Movies", "Psycho (1960)", "We're always quickest to doubt people who have a reputation for being honest."]
            ,75:["Movies", "The Shining", "Some places are like people. Some shine and some don't."]
            ,76:["Movies", "The Nightmare Before Christmas", "I am the shadow on the moon at night filling your dreams to the brim with fright."]
            ,77:["Movies", "Reservoir Dogs", "You kids shouldn't play so rough. Somebody's gonna start cryin'."]
            ,78:["Movies", "Memento", "We all need mirrors to remind ourselves who we are."]
            ,79:["Movies", "Memento", "If we can't make memories we can't heal."]
            ,80:["Movies", "Memento", "So you lie to yourself to be happy. There's nothing wrong with that. We all do it."]
            ,81:["Movies", "Edward Scissorhands", "Sweetheart you can't buy the necessities of life with cookies."]
            ,82:["Movies", "The Shawshank Redemption", "I was in the path of the tornado... I just didn't expect the storm would last as long as it has."]
            ,83:["Movies", "The Shawshank Redemption", "Let me tell you something my friend. Hope is a dangerous thing. Hope can drive a man insane."]
            ,84:["Movies", "Sleepy Hollow", "Villainy wears many masks none so dangerous as the mask of virtue."]
            ,85:["Movies", "A Clockwork Orange", "It's funny how the colors of the real world only seem really real when you viddy them on the screen."]
            ,86:["Movies", "V for Vendetta", "People should not be afraid of their governments. Governments should be afraid of their people."]
            ,87:["Movies", "V for Vendetta", "But again truth be told if you're looking for the guilty you need only look into a mirror."]
            ,88:["Movies", "V for Vendetta", "You wear a mask for so long you forget who you were beneath it."]
            ,89:["Movies", "The Jungle Book", "It's like you said. You can't trust anyone!"]
            ,90:["Movies", "Shrek", "NO! Not the buttons! Not my gumdrop buttons!"]
            ,91:["Movies", "Shrek", "Now really it's rude enough being alive when no one wants you but showing up uninvited to a wedding?"]
            ,92:["Movies", "American Beauty", "I had always heard your entire life flashes in front of your eyes the second before you die."]
            ,93:["Movies", "American Beauty", "And you're boring and you're totally ordinary and you know it."]
            ,94:["Movies", "American Beauty", "She's not your friend. She's just someone you use to feel better about yourself."]
            ,95:["Movies", "Mary and Max", "Max knew nothing about love. It was as foreign to him as a salad sandwich."]
            ,96:["Movies", "The Babadook", "You can't get rid of the Babadook."]
            ,97:["Movies", "Little Miss Sunshine", "A real loser is someone who's so afraid of not winning he doesn't even try."]
            ,98:["Movies", "Groundhog Day", "What would you do if you were stuck in one place and every day was exactly the same and nothing that you did mattered?"]
            ,99:["Movies", "Groundhog Day", "I'll give you a winter prediction. It's gonna be cold it's gonna be grey and it's gonna last you for the rest of your life."]
            ,100:["Movies", "Waking Life", "The worst mistake that you can make is to think you're alive when really you're asleep in life's waiting room."]
        //    ,101:["Movies", "Super", "I kind of think happiness is over-rated. People spend their whole lives chasing it like it's the most important thing in the world. Happy people are kind of arrogant."]
        //    ,102:["Movies", "The Shawshank Redemption", "Rehabilitated? Well now let me see. You know I don't have any idea what that means."]
    ]
    
    func generateQuote() -> String
    {
        let pickedQuote = quoteList[seed]![2]
        
        return pickedQuote
    }
    
    func quoteSource() -> String
    {
        let pickedQuoteSource = quoteList[seed]![1]
        
        return pickedQuoteSource
    }
    
    func quoteSourceWithInputSeed(_ inputSeed: Int) -> String
    {
        let pickedQuoteSource = quoteList[inputSeed]![1]
        
        return pickedQuoteSource
    }
    
    func quoteCategory() -> String
    {
        let pickedQuoteCategory = quoteList[seed]![0]
        
        return pickedQuoteCategory
    }
    
    func quotesFromSpecificCategory(_ category: String) -> [Int]
    {
        var quoteSeedList: [Int] = []
        
        for x in (0..<quoteList.count)
        {
            if quoteList[x]![0] == category
            {
                quoteSeedList.append(x)
            }
        }
        
        return quoteSeedList
    }
    
    func listOfCategories() -> [String]
    {
        var quoteCategoryList: [String] = []
        
        for x in (0..<quoteList.count)
        {
            if quoteCategoryList.contains(quoteList[x]![0]) == false
            {
                quoteCategoryList.append(quoteList[x]![0])
            }
        }
        return quoteCategoryList
    }
    /*
     
    func generateQuote() -> String
    {
        let quoteList: [Int: String] =
        [
         0: "You're gonna need a bigger boat"
        ,1: "Things change. And friends leave. Life doesn't stop for anybody."
        ,2: "Please boss, don't put that thing over my face, don't put me in the dark. I's afraid of the dark."
        ,3: "I'm sorry, Wilson. Wilson, I'm sorry! I'm sorry!"
        ,4: "Dad, Dad, come on, you gotta get up. Dad, we gotta go home."
        ,5: "You never forget kids like Emily, or Andy, but they forget you."
        ,6: "Time just gets away from us."
        ,7: "I'm so sorry. I failed you. You trusted me, and I failed you."
        ,8: "Littlefoot, let your heart guide you. It whispers so listen closely."
        ,9: "I promised a friend I would say hello to you today. Please say hello to me. Please say hello to me."
        ,10: "And I guess that was your accomplice in the wood chipper."
        ,11: "Someone has to die in order that the rest of us should value life more. It's contrast."
        ,12: "No Mr. Bond. I expect you to die!"
        ,13: "We all go a little mad sometimes."
        ,14: "Live for nothing or die for something."
        ,15: "I can't go back to yesterday because I was a different person then."
        ,16: "You're at peace because you know it's okay to be afraid."
        ,17: "If you don't think, then you shouldn't talk."
        ,18: "Nature can be lethal. But it doesn't hold a candle to man."
        ,19: "The ability to speak does not make you intelligent."
        ,20: "This is your life and it's ending one second at a time."
        ,21: "When the fight was over, nothing was solved, but nothing mattered. We all felt saved."
        ,22: "The concept of wuv confuses and infuriates us!"
        ,23: "Your only limit is your soul."
        ,24: "Do not pity the dead Harry. Pity the living, and, above all, those who live without love."
        ,25: "You tried your best and you failed miserably. The lesson is never try."
        ,26: "I want to make this family love me. How much money you got?"
        ,27: "Nobody takes a picture of something they want to forget"
        ,28: "You are not special. You are not a beautiful or unique snowflake. You are the same decaying organic matter as everything else."
        ,29: "You're worth more dead than alive!"
        ,30: "If he dies, he dies."
        ,31: "I'm every nightmare you've ever had. I'm your worst dream come true. I'm everything you ever were afraid of."
        ,32: "Now where were we? Ah, yes, abject humiliation!"
        ,33: "People scare better when they're dying."
        ,34: "You'd do better to tell us everything. But to make sure it happens, I brought along a few tools."
        ,35: "I have a competition in me. I want no one else to succeed. I hate most people."
        ,36: "Get busy living, or get busy dying."
        ,37: "Life is only on earth, and not for long."
        ,38: "Bad things happen, and you can't do anything about it."
        ,39: "You're a sad strange little man and you have my pity."
        ,40: "But if you want to leave, you can. I'll remeber you though. I remember everyone that leaves."
        ,41: "You said you'd always be there for me! But you're not."
        ,42: "The human world is a mess."
        ,43: "I just thought there'd be more, you know?"
        ,44: "You've been living in a dream world, Neo."
        ,45: "Some people are just born with tragedy in their blood."
        ,46: "Every creature on this earth dies alone."
        ,47: "You are a fear prisoner. Yes, you are a product of fear."
        ,48: "If the sky were to suddenly open up, there would be no law, there would be no rule. There would only be you and your memories."
        ,49: "There are no two words in the English language more harmful than good job."
        ,50: "If you don't have ability, you wind up playing in a rock band."
        ,51: "I've still got things left to do."
        ,52: "That's what the present is. It's a little unsatisfying because life is unsatisfying."
        ,53: "Ernest Hemingway once wrote, the world is a fine place and worth fighting for. I agree with the second part."
        ,54: "Imagine if you suddenly learned that the people, the places, the moments most important to you were not gone, not dead, but worse, had never been. What kind of hell would that be?"
        ,55: "Classes will dull your mind, destroy the potential for authentic creativity."
        ,56: "They are my past. Everyone is haunted by their past."
        ,57: "I tried taking pictures, but they were so mediocre."
        ,58: "Why do you have to point out how stupid everyone is all the time?"
        ,59: "You either die a hero or you live long enough to see yourself become the villain."
        ,60: "You thought we could be decent men in an indecent time. But you were wrong. The world is cruel, and the only morality in a cruel world is chance."
        ,61: "You have nothing, nothing to threaten me with. Nothing to do with all your strength."
        ,62: "Oh, you're too late. There's really nothing left to explore."
        ,63: "Once you're in hell, only the devil can help you out."
        ,64: "Until a person is faced with death, it's impossible to tell whether they have what it takes to survive."
        ,65: "People look stupid when they cry."
        ,66: "ok"
       // ,66: "I kind of think happiness is over-rated. People spend their whole lives chasing it, like it's the most important thing in the world. Happy people are kind of arrogant."
        ,67: "Fear is the little death that brings total obliteration"
        ,68: "Without change, something sleeps inside of us and seldom awakens."
        ,69: "I'm dead to everyone unless I become what I may be."
        ,70: "Loneliness has followed me my whole life, everywhere. In bars, in cars, sidewalks, stores, everywhere. There's no escape. I'm God's lonely man."
        ,71: "I once had a horse, on Coney Island. She got hit by a car."
        ,72: "Twelve hours of work and I still can't sleep."
        ,73: "We're always quickest to doubt people who have a reputation for being honest."
        ,74: "Some places are like people. Some shine and some don't."
        ,75: "I am the shadow on the moon at night, filling your dreams to the brim with fright."
        ,76: "You kids shouldn't play so rough. Somebody's gonna start cryin'."
        ,77: "We all need mirrors to remind ourselves who we are."
        ,78: "If we can't make memories, we can't heal."
        ,79: "So you lie to yourself to be happy. There's nothing wrong with that. We all do it."
        ,80: "Sweetheart, you can't buy the necessities of life with cookies."
            ,81: "placeholder"
     //   ,81: "Rehabilitated? Well, now let me see. You know, I don't have any idea what that means."
        ,82: "I was in the path of the tornado... I just didn't expect the storm would last as long as it has."
        ,83: "Let me tell you something my friend. Hope is a dangerous thing. Hope can drive a man insane."
        ,84: "Villainy wears many masks, none so dangerous as the mask of virtue."
        ,85: "It's funny how the colors of the real world only seem really real when you viddy them on the screen."
        ,86: "People should not be afraid of their governments. Governments should be afraid of their people."
        ,87: "But again, truth be told, if you're looking for the guilty you need only look into a mirror."
        ,88: "You wear a mask for so long, you forget who you were beneath it."
        ,89: "It's like you said. You can't trust anyone!"
        ,90: "NO! Not the buttons! Not my gumdrop buttons!"
        ,91: "Now really, it's rude enough being alive when no one wants you, but showing up uninvited to a wedding?"
        ,92: "I had always heard your entire life flashes in front of your eyes the second before you die."
        ,93: "And you're boring, and you're totally ordinary, and you know it."
        ,94: "She's not your friend. She's just someone you use to feel better about yourself."
        ,95: "Max knew nothing about love. It was as foreign to him as a salad sandwich."
        ,96: "You can't get rid of the Babadook."
        ,97: "A real loser is someone who's so afraid of not winning he doesn't even try."
        ,98: "What would you do if you were stuck in one place and every day was exactly the same, and nothing that you did mattered?"
        ,99: "I'll give you a winter prediction. It's gonna be cold, it's gonna be grey, and it's gonna last you for the rest of your life."
        ,100: "The worst mistake that you can make is to think you're alive when really you're asleep in life's waiting room."
        ]
        
        
        let pickedQuote = quoteList[seed]
        
        return pickedQuote!
    }
    
    func quoteSource() -> String
    {
    let quoteList: [Int: String] =
    [
         0: "Jaws"
        ,1: "The Perks of Being a Wallflower"
        ,2: "The Green Mile"
        ,3: "Cast Away"
        ,4: "The Lion King"
        ,5: "Toy Story 2"
        ,6: "True Grit (2012)"
        ,7: "The Dark Knight Rises"
        ,8: "The Land Before Time"
        ,9: "I Am Legend"
        ,10: "Fargo (1996)"
        ,11: "The Hours (2002)"
        ,12: "Goldfinger (1964)"
        ,13: "Psycho (1960)"
        ,14: "Rambo"
        ,15: "Alice In Wonderland"
        ,16: "Mulan"
        ,17: "Alice In Wonderland"
        ,18: "Deep Blue Sea"
        ,19: "Star Wars Episode I"
        ,20: "Fight Club"
        ,21: "Fight Club"
        ,22: "Futurama"
        ,23: "Ratatouille"
        ,24: "Harry Potter"
        ,25: "The Simpsons"
        ,26: "The Royal Tenenbaums (2001)"
        ,27: "One Hour Photo (2002)"
        ,28: "Fight Club (1999)"
        ,29: "It's a Wonderful Life (1946)"
        ,30: "Rocky IV"
        ,31: "It"
        ,32: "Aladdin"
        ,33: "Once Upon A Time In The West"
        ,34: "Pan's Labyrinth"
        ,35: "There Will Be Blood"
        ,36: "The Shawshank Redemption"
        ,37: "Melancholia"
        ,38: "The Lion King"
        ,39: "Toy Story"
        ,40: "Lilo and Stitch"
        ,41: "The Lion King"
        ,42: "The Little Mermaid"
        ,43: "Boyhood"
        ,44: "The Matrix"
        ,45: "Donnie Darko"
        ,46: "Donnie Darko"
        ,47: "Donnie Darko"
        ,48: "Donnie Darko"
        ,49: "Whiplash"
        ,50: "Whiplash"
        ,51: "Breaking Bad"
        ,52: "Midnight in Paris"
        ,53: "Se7en"
        ,54: "A Beautiful Mind"
        ,55: "A Beautiful Mind"
        ,56: "A Beautiful Mind"
        ,57: "Lost in Translation"
        ,58: "Lost in Translation"
        ,59: "The Dark Knight"
        ,60: "The Dark Knight"
        ,61: "The Dark Knight"
        ,62: "The Truman Show"
        ,63: "Saw II"
        ,64: "Saw VI"
        ,65: "Super"
        ,66: "ok"
      //  ,66: "Super"
        ,67: "Dune"
        ,68: "Dune"
        ,69: "Dune"
        ,70: "Taxi Driver"
        ,71: "Taxi Driver"
        ,72: "Taxi Driver"
        ,73: "Psycho (1960)"
        ,74: "The Shining"
        ,75: "The Nightmare Before Christmas"
        ,76: "Reservoir Dogs"
        ,77: "Memento"
        ,78: "Memento"
        ,79: "Memento"
        ,80: "Edward Scissorhands"
        ,81: "placeholder..."
    //    ,81: "The Shawshank Redemption"
        ,82: "The Shawshank Redemption"
        ,83: "The Shawshank Redemption"
        ,84: "Sleepy Hollow"
        ,85: "A Clockwork Orange"
        ,86: "V for Vendetta"
        ,87: "V for Vendetta"
        ,88: "V for Vendetta"
        ,89: "The Jungle Book"
        ,90: "Shrek"
        ,91: "Shrek"
        ,92: "American Beauty"
        ,93: "American Beauty"
        ,94: "American Beauty"
        ,95: "Mary and Max"
        ,96: "The Babadook"
        ,97: "Little Miss Sunshine"
        ,98: "Groundhog Day"
        ,99: "Groundhog Day"
        ,100: "Waking Life"
    ]
    
    
    let pickedQuote = quoteList[seed]
    
    return pickedQuote!
    }
 */
}

/* 
 Puns
 I used to be Snow White, but I drifted
 
 Out of context..
 "I don't have any toes!" - Shrek
 
 
*/
