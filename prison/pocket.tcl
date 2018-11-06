
namespace eval Prison::Pocket {

    proc theater {} {
        puts "== Theater =="
        puts "As you wander about, you see just how large the theater really is.\
        There is a balcony section above your head that you aren't sure how to get\
        to. The exits are in the back and appear to be unlocked."
        prompt {} {
            {"Sit down" yes theaterSeat}
            {"Go outside" yes center}
        }
    }

    proc theaterSeat {} {
        puts "== Theater House =="
        puts "The theater is very large, and it is clearly very packed. There is some\
        sort of dance show going on on the stage, and Silver Starlight seems to be a\
        participant, playing along for the moment. You are in an edge seat, so it would\
        be relatively easy to leave if you so chose. The man sitting next to you is bald\
        and rather intimidating."
        prompt {} {
            {"Enjoy the show" yes theaterShow}
            {"Talk to the bald man" yes theaterTalk}
            {"Get up" yes theater}
        }
    }

    proc theaterTalk {} {
        puts "You try to talk to the bald gentleman but find yourself completely ignored.\
        Not only does he not respond, but he doesn't even blink or turn his head in your\
        direction."
        state put spirit-bald yes
        puts {}
        return theaterSeat
    }

    proc theaterShow {} {
        puts "You decide to sit back and enjoy the show. The performers are quite good, and\
        the dances go on for quite some time. At the end, all of the performers, including\
        Starlight, file off backstage, and the audience begins to empty into the street out\
        the opposite entrance."
        state put false-stage outside
        prompt {} {
            {"Exit with the crowd" yes theaterExit}
            {"Hide in the shadows" yes theaterHide}
        }
    }

    proc theaterHide {} {
        puts "You quietly move over toward the shadows as the audience exits. Fairly quickly,\
        you are alone in the auditorium. As you stand in silence, the shadows in the floor\
        begin to shift toward the stage. Your own shadow leaps out of the ground, taking the\
        form of some sort of mutant lizard. The lizard creature dives at you and strikes you\
        with its claws. A bright white light engulfs you."
        state put spirit-lizard yes
        puts {}
        return ::Prison::Cottage::shed
    }

    proc theaterExit {} {
        puts "As soon as you exit the theater, the entire crowd is gone. There is no trace of\
        the hundreds of people who once filled the auditorium."
        puts {}
        return center
    }

    proc theaterShowtime {} {
        puts "== Theater Stage =="
        # //// Silver Coin available here
        puts "You find yourself on the stage of the large theater. The seats are occupied\
        by strange shadows which shift slowly from side to side. You are standing just out of\
        sight right now."
        prompt {} {
            {"Step into the light" yes theaterShowtime1}
            {"Go outside" yes theaterBack}
        }
    }

    proc theaterShowtime1 {} {
        puts "At your approach, several of the shadows converge around you and grab\
        hold of your arms and legs. One of the shadows materializes into one of the\
        dancers from the show before."
        puts "\"You come here unarmed and expect to defeat us? You will suffer in an\
        eternal purgatory.\""
        prompt {} {
            {"\"This is all going according to plan.\"" yes {showtimePlan plan}}
            {"\"Look out behind you!\"" yes {showtimePlan behind}}
        }
    }

    proc showtimePlan {response} {
        if {$response eq {plan}} then {
            puts "\"Clearly.\""
        } else {
            puts "\"Is that the best you can come up with?\""
        }
        puts "As she says this, Silver Starlight kicks down the back door of the\
        auditorium, magic scepter in hand."
        puts "\"Alright! Who's first?\""
        puts "With a single magic word and a flash of white light, Starlight dispels\
        all of the shadows in the room."
        puts "\"There's a secret room underneath the arcade! I think it's some sort\
        of shrine. We need to hurry!\""
        prompt {} {
            {"\"Lead the way.\"" yes showtimePlan1}
        }
    }

    proc showtimePlan1 {} {
        puts "Starlight runs out of the theater toward the arcade."
        puts {}
        # //// A separate file with the "dark" versions of the areas
        return -gameover
    }

    proc theaterBack {} {
        puts "== Behind the Theater =="
        switch [state get false-stage] {
            no - dance - theater - town {
                puts "The area behind the theater is sparse and empty, with an employee entrance\
                and not much else."
            }
            outside {
                puts "The area behind the theater is sparse and empty. Silver Starlight is standing\
                by the employee entrance, seemingly waiting for you."
            }
        }
        prompt {} {
            {"Enter the theater" yes enterTheaterBack}
            {"Talk to Starlight" {[state get false-stage] eq {outside}} starlight}
            {"Go back to the square" yes center}
        }
    }

    proc center {} {
        puts "== Pastel Town Square =="
        puts "The town square is unnaturally bright, with the sun directly overhead and the\
        buildings consisting of unusual pastel colors. The path continues to the north and\
        the south, and the theater is right in the center of town."
        prompt {} {
            {"Enter the theater" yes enterTheater}
            {"Go behind the theater" yes theaterBack}
            {"Go north" yes north}
            {"Go south" yes south}
        }
    }

    proc north {} {
        puts "== Pastel Town - North Edge =="
        puts "The north edge of the town is equally pastel-shaded. Of particular interest\
        in the immediate area is an arcade. Further to the north, the air starts to look\
        more pixelated."
        prompt {} {
            {"Enter the arcade" yes arcade}
            {"Go further north" yes fadeOut}
            {"Go south" yes center}
        }
    }

    proc south {} {
        puts "== Pastel Town - South Edge =="
        puts "The south edge of the town is incredibly colorful, like the rest of the area.\
        There is a bakery on the left side of the path. Further south, the air appears to\
        become oddly pixelated."
        prompt {} {
            {"Enter the bakery" yes bakery}
            {"Go north" yes center}
            {"Go further south" yes fadeOut}
        }
    }

    proc arcade {} {
        puts "== Pastel Town - Arcade =="
        puts -nonewline  "In the arcade, there are a handful of unfamiliar games. A teenager\
        is standing against the wall."
        if {[state get false-stage] eq {theater}} then {
            puts " Starlight is examining the back of an arcade machine."
        } else {
            puts {}
        }
        prompt {} {
            {"Play a game" yes arcadeGame}
            {"Talk to Starlight" yes arcadeStarlight}
            {"Talk to the teenager" yes arcadeTalk}
            {"Go outside" yes north}
        }
    }

    proc arcadeGame {} {
        # //// You'll win this if it's time
        puts "You approach one of the games and begin to play. The display doesn't seem\
        to make a lot of sense, and you ultimately end up losing without really knowing\
        how to play."
        puts {}
        return arcade
    }

    proc arcadeTalk {} {
        puts "You attempt to strike up conversation with the teenager, who simply stands there\
        staring forward, not even acknowledging your presence."
        state put spirit-gamer yes
        puts {}
        return arcade
    }

    proc arcadeStarlight {} {
        puts "\"Go check out the theater! We'll meet up again later.\""
        puts {}
        return arcade
    }

    proc bakery {} {
        puts "== Pastel Town - Bakery =="
        switch [state get false-stage] {
            no - dance - outside - theater - town {
                if {[state get spirit-muffin] eq {no}} then {
                    puts "The inside of the bakery is incredibly colorful. There are several\
                    people sitting at the tables, seemingly enjoying a pleasant snack. The baker\
                    is standing behind the counter, and a muffin sits on a display case in front\
                    of him."
                } else {
                    puts "The inside of the bakery is incredibly colorful. There are several\
                    people sitting at the tables, seemingly enjoying a pleasant snack. The baker\
                    is standing behind an empty display case on the counter."
                }
            }
        }
        prompt {} {
            {"Talk to the baker" {[state get false-stage] in {no dance outside}} bakeryTalk}
            {"Take the muffin" {[state get spirit-muffin] eq {no}} bakeryMuffin}
            {"Go outside" yes south}
        }
    }

    proc bakeryMuffin {} {
        # //// In the right state, you get the muffin
        state put spirit-baker yes
        puts "The baker grabs your arm and lifts a butcher's knife with his other hand.\
        As he lowers the large knife toward you, a bright light engulfs you."
        puts {}
        return ::Prison::Cottage::shed
    }

    proc bakeryTalk {} {
        puts "The baker pays you no mind, no matter what you say to him. He merely\
        goes about his business."
        state put spirit-baker yes
        puts {}
        return bakery
    }

    proc starlight {} {
        puts "\"Alright, this place is weird. I tried talking to another one of the\
        performers, but she just didn't respond. It's like she couldn't even hear me.\
        Anyway, I... uh, I lost my scepter again on the way in, so I can't exactly\
        figure out what's going on right now.\""
        prompt {} {
            {"\"What should we do?\"" yes starlight1}
        }
    }

    proc starlight1 {} {
        puts "\"I think it's best if we split up. One of us can stay here and check out\
        the theater. The other should investigate the rest of the town.\""
        prompt {} {
            {"\"I'll take the theater.\"" yes starlightTheater}
            {"\"I'll check out the town.\"" yes starlightTown}
        }
    }

    proc starlightTheater {} {
        puts "\"Sounds good! We'll meet back here later!\""
        puts "Starlight runs off into the town."
        state put false-stage theater
        puts {}
        return theaterBack
    }

    proc starlightTown {} {
        puts "\"Sounds good! We'll meet back here later!\""
        puts "Starlight hurries back into the theater."
        state put false-stage town
        puts {}
        return theaterBack
    }

    proc fadeOut {} {
        puts "A bright light engulfs you."
        puts {}
        return ::Prison::Cottage::shed
    }

    proc enterTheater {} {
        switch [state get false-stage] {
            no - dance {
                return theater
            }
            default {
                puts "The theater entrance is locked."
                puts {}
                return center
            }
        }
    }

    proc enterTheaterBack {} {
        switch [state get false-stage] {
            theater {
                return theaterShowtime
            }
            default {
                puts "The theater entrance is locked."
                puts {}
                return theaterBack
            }
        }
    }

}