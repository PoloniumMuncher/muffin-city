
namespace eval Inverse::School {

    proc innerGate {} {
        puts "=~ School Gate ~="
        puts -nonewline "The front of the school campus is gated\
        off, likely to prevent undesired escape by students.\
        The main building itself is tall and foreboding, tiled\
        with red brick but obviously kept up well. There is\
        a single entrance into the front of the school."
        if {[state get school-period] in {first third}} then {
            puts " A large yellow bus is sitting by the closed gate.\
            Standing at the door to the bus is Carl."
        } else {
            puts {}
        }
        prompt {} {
            {"Talk to Carl" {[state get school-period] in {first third}} carl}
            {"Go inside" yes south}
        }
    }

    proc south {} {
        puts "=~ School Hall - South ~="
        # ////
        # //// Janitor's Closet (or equivalent)
        prompt {} {
            {"Walk down the hallway" yes north}
            {"Go to the dorms" yes dorms}
            {"Go outside" yes innerGate}
        }
    }

    proc north {} {
        puts "=~ School Hall - North ~="
        # ////
        prompt {} {
            {"Walk down the hallway" yes south}
            {"Enter the bathroom" yes bathroom}
            {"Go to the cafeteria" yes cafeteria}
            {"Head into the classroom" yes classroom}
        }
    }

    proc dorms {} {
        puts "=~ Dormitories ~="
        # ////
        prompt {} {
            {"Go to sleep in one of the beds" yes ::Inverse::District::sleepDeath}
            {"Go back to the hallway" yes south}
        }
    }

    proc bathroom {} {
        puts "=~ School Bathroom ~="
        # ////
        prompt {} {
            {"Go back to the hallway" yes north}
        }
    }

    proc cafeteria {} {
        puts "=~ Cafeteria ~="
        # ////
        prompt {} {
            {"Back to the hallway" yes north}
        }
    }

    proc classroom {} {
        puts "=~ Classroom ~="
        puts -nonewline "An expansive chalkboard takes up the front half of the room,\
        standing before a podium and several rows of desks."
        switch [state get school-period] {
            no {
                puts " The room itself is empty, no teacher or students. It seems as\
                though nothing is happening here right now."
            }
            first {
                puts " There are several students occupying the seats, waiting\
                patiently and silently. No one is yet at the podium."
                # //// You can try to occupy the podium and challenge the Judge
            }
            second {
                puts " Several students occupy seats sporadically throughout the\
                room, sitting silently and staring forward. Nobody is occupying\
                the podium."
                # //// You can try to occupy the podium and challenge Mavis
            }
            third {
                puts " There are a handful of students in the room, waiting patiently.\
                A man wearing glasses with a nametag marked \"Todd\" is standing at the\
                podium in the front."
                # //// Talking to Todd
            }
        }
        prompt {} {
            {"Take a seat" yes ::Inverse::Class::seat}
            {"Back to the hallway" yes north}
        }
    }

    proc carl {} {
        if {[state get school-period] eq {third}} then {
            puts "\"Go ahead and head over to the classroom. I'll be one of\
            the instructors in your next class.\""
        } else {
            puts "\"Welcome to the Robot King's reeducation facility. Please\
            head on inside.\""
        }
        prompt {} {
            {"\"Can I leave?\"" yes carlLeave}
            {"\"Will do.\"" yes innerGate}
        }
    }

    proc carlLeave {} {
        puts "\"You are welcome on the next bus out, as soon as you pass your\
        classes.\""
        puts {}
        return innerGate
    }

    proc bus {} {
        state put school-period first
        if {[state get been-to-school] eq {yes}} then {
            puts "You take a seat on the bus, which is mostly empty. The bus ride is\
            fairly uneventful, and some time later the bus pulls into a large gated\
            school. The other passengers disembark and head inside."
            prompt {} {
                {"Disembark" yes innerGate}
            }
        } else {
            puts "You take a seat on the bus, which is already mostly filled with\
            other people. A moment later, a young woman in a black dress frantically\
            waves the bus down and climbs aboard, taking the seat next to yours. The\
            bus sets off. After a moment, the young woman speaks to you."
            puts "\"First time being reeducated? Sorry, it's just, I don't think\
            I've seen you here before.\""
            state put been-to-school yes
            prompt {} {
                {"\"That's right.\"" yes bus1}
            }
        }
    }

    proc bus1 {} {
        puts "\"That's okay. It's not as bad as it sounds. There's three classes,\
        and at the end they'll give you a grade. If you pass, you get to leave. If\
        you fail, you have to do it all again.\""
        prompt {} {
            {"\"You sound like you've done this before.\"" yes bus2}
        }
    }

    proc bus2 {} {
        puts "\"I've been here a couple of times. You know how it is, your hypnotism starts\
        to slip but you don't want to go see the Mesmerist. The school can really help\
        with that. Gets rid of all of those anti- Robot King thoughts.\""
        prompt {} {
            {"\"Thanks. I'm sure it'll be fun.\"" yes busFun}
            {"\"I'm not actually hypnotized.\"" yes busNo}
        }
    }

    proc busFun {} {
        puts "\"It is! By the way, you can call me Starlight! Silver Starlight! All of\
        my friends do.\""
        prompt {} {
            {"\"Noted, Starlight.\"" yes busDepart}
        }
    }

    proc busNo {} {
        puts "\"Wow, your hypnotism must really be slipping. It's a good thing you came\
        here when you did. Oh, by the way, you can call me Silver Starlight! All of\
        my friends do.\""
        prompt {} {
            {"\"Will do.\"" yes busDepart}
        }
    }

    proc busDepart {} {
        puts "The bus pulls into a large gated campus, and the passengers begin to depart.\
        Starlight rises from her seat and makes a motion to leave."
        puts "\"See you in class!\""
        prompt {} {
            {"Step off the bus" yes innerGate}
        }
    }

}