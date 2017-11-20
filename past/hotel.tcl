
namespace eval Past::Hotel {

    proc ritzyHall {} {
        puts "== Past Ritzy Inn - Hallway =="
        puts "The hallway stretches on for quite a ways, and there appear to be\
        several floors above this one."
        prompt {} {
            {"Go to Room 211" {[inv has {Ritzy Inn Room Key}]} ritzyRoom}
            {"Go to the basement" {[state get heard-science] eq {yes}} ::Past::Science::mainRoom}
            {"Go to the lobby" yes ritzyInn}
        }
    }

    proc ritzyRoom {} {
        puts "== Past Ritzy Inn - Bedroom =="
        puts "The key card to Room 211 opens the door. There is another party's luggage laying on\
        the floor of the room. Clearly, someone else has the room right now."
        # //// Something in the luggage to steal
        prompt {} {
            {"Go to sleep" yes ::Dream::Transit::firstRoom}
            {"Exit the room" yes ritzyHall}
        }
    }

    proc ritzyInn {} {
        puts "== Past Ritzy Inn =="
        puts "This is obviously a high-class building. There are several people moving to and fro,\
        all of them dressed in the finest garb. Behind a large \"Guest Services\" counter sits a\
        young man with glasses. The bronze nameplate in front of him informs you that his name\
        is Todd."
        prompt {} {
            {"Talk to Todd" yes ritzyTalk}
            {"Go toward the hallway" yes ritzyHall}
            {"Leave" yes ::Past::District::hotel}
        }
    }

    proc ritzyTalk {} {
        puts "\"I'm terribly sorry, but we don't have any vacancies at the moment. Please\
        come back at one o'clock after today's guests have departed.\""
        # //// Something else for Todd to do (show him his note to go to subspace?)
        prompt {} {
            {"\"Never mind.\"" yes ritzyInn}
        }
    }

    proc shabbyJack {} {
        puts "== Shabby Jack's - Past =="
        puts -nonewline "The facility is clearly a low-class establishment, but it has a\
        certain rustic charm to it. There is a hallway leading back with a sign that\
        says \"Guests Only\", and behind a wooden counter there is a man with a nametag\
        reading \"Shabby Jack\"."
        switch [state get attorney-man] {
            no {
                puts " A man in an elaborate superhero costume and a red cape and mask is\
                sitting on a chair in the corner."
            }
            default {
                puts " Attorney-Man is sitting on a chair in the corner, his hands folded in\
                his lap."
            }
        }
        prompt {} {
            {"Talk to Shabby Jack" yes shabbyTalk}
            {"Talk to the superhero" {[state get attorney-man] eq {no}} shabbyAttorney}
            {"Talk to Attorney-Man" {[state get attorney-man] ne {no}} shabbyAttorney}
            {"Enter your room" {[inv has {Motel Room Key}]} shabbyRoom}
            {"Leave" yes ::Past::District::hotel}
        }
    }

    proc shabbyAttorney {} {
        switch [state get attorney-man] {
            no {
                puts "\"Leave me alone.\""
                prompt {} {
                    {"\"Who are you?\"" yes shabbyAttorney1}
                    {"\"Okay, sorry.\"" yes shabbyJack}
                }
            }
            met {
                puts "\"Leave me alone.\""
                prompt {} {
                    {"\"You can do it!\"" yes shabbyAttorneyYes}
                    {"\"Okay, sorry.\"" yes shabbyJack}
                }
            }
            default {
                puts "\"Today, I'm going to go change the world!\""
                puts {}
                return shabbyJack
            }
        }
    }

    proc shabbyAttorney1 {} {
        state put attorney-man met
        puts "\"Well, if you must know...\""
        puts "The strange man rises from his chair and strikes a heroic pose with his hands\
        on his hips."
        puts "\"I'm Attorney-Man! Evildoers beware! I defend mankind's rights under the law!\
        I'll take on any client, no matter how hopeless! And I've never lost a case!\""
        puts "Attorney-Man sits back down."
        puts "\"But... the judge threw me out of the courtroom. I think he's tired of dealing\
        with me...\""
        prompt {} {
            {"\"You can do it!\"" yes shabbyAttorneyYes}
            {"\"I'm sorry...\"" yes shabbyAttorneyNo}
        }
    }

    proc shabbyAttorneyYes {} {
        state put attorney-man talked
        puts "\"You know what? You're right! That judge can throw me out of every case\
        but I won't quit! Because I fight for justice and I won't let any judges get in\
        my way! Today, I'm going to go find a new client and bring justice for all!\""
        puts {}
        return shabbyJack
    }

    proc shabbyAttorneyNo {} {
        puts "\"I'll be fine. Just leave me alone...\""
        puts {}
        return shabbyJack
    }

    proc shabbyTalk {} {
        puts "\"Welcome to Shabby Jack's Streetside Motel! We haven't finished cleaning\
        the rooms yet, so you'll have to come back in a few hours.\""
        prompt {} {
            {"\"Oh, okay.\"" yes shabbyJack}
        }
    }

    proc shabbyRoom {} {
        puts "\"Whoa, hold on there! We still need to clean up the rooms before we can\
        have any guests back there. You'll have to come back in a bit.\""
        puts {}
        return shabbyJack
    }

}
