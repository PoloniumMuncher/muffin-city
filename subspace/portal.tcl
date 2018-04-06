
namespace eval Subspace::Portal {

    proc portalRoom {} {
        puts "== Subspace Projection Room =="
        switch [state get subspace-portal] {
            no {
                puts -nonewline "The projector sits in the middle of the room and appears to\
                currently be inactive."
            }
            river {
                puts -nonewline "The projector in the middle of the room is active and\
                projects a calm, cold river."
            }
        }
        if {[state get hero-blade] eq {no}} then {
            puts " A young woman in silver armor is standing next to the projector."
        } elseif {[state get necro-cipher] eq {help}} {
            puts {}
        } else {
            puts " Atheena is standing next to the projector."
        }
        prompt {} {
            {"Talk to the woman" {[state get hero-blade] eq {no}} atheena}
            {"Talk to Atheena" {([state get hero-blade] ne {no}) && ([state get necro-cipher] ne {help})} atheena}
            {"Pass through the portal" {[state get subspace-portal] ne {no}} portal}
            {"Head back to the hub" yes ::Subspace::Hub::hub}
        }
    }

    proc portal {} {
        switch [state get subspace-portal] {
            river {
                return ::Prison::Forest::river
            }
        }
    }

    proc atheena {} {
        switch [state get hero-blade] {
            no {
                puts "\"Greetings! I am Atheena, hero of the Seven Seas! How do you do?\""
                state put hero-blade met
                prompt {} {
                    {"\"What are you doing in subspace?\"" yes atheenaIntro}
                    {"\"Goodbye.\"" yes portalRoom}
                }
            }
            met {
                puts "\"Greetings!\""
                prompt {} {
                    {"\"What are you doing in subspace?\"" yes atheenaIntro}
                    {"\"Goodbye.\"" yes portalRoom}
                }
            }
            talked {
                puts "\"Greetings!\""
                prompt {} {
                    {"\"Could you turn the portal on?\"" {[state get subspace-portal] eq {no}} basicPortal}
                    {"\"Is that the only place the portal can go?\"" {([state get subspace-portal] ne {no}) && ([state get hero-crystal] eq {no})} atheenaCrystal}
                    {"\"There's a madman at the taco shop!\"" {[state get necro-cipher] eq {rising}} atheenaHelp}
                    {"\"Goodbye.\"" yes portalRoom}
                }
            }
            yes {
                # ////
                return -gameover
            }
        }
    }

    proc atheenaIntro {} {
        puts "\"Alas, I was trapped here by an evil wizard, with no way to return to my own\
        time. And thus, I have learned the ways of the portal projector. If you would like me\
        to activate the portal device, please let me know.\""
        state put hero-blade talked
        prompt {} {
            {"\"Please turn it on.\"" yes basicPortal}
            {"\"Maybe later.\"" yes portalRoom}
        }
    }

    proc atheenaHelp {} {
        puts "\"A madman?! How foul! Come, we shall defeat this villain together!\""
        puts "Without another word, Atheena races toward the taco shop, her hand\
        on the hilt of her blade."
        state put necro-cipher help
        puts {}
        return portalRoom
    }

    proc atheenaCrystal {} {
        puts "\"Once upon a time, it could be modified. The projector is operated by a\
        specially-cut diamond. But the bank claimed my diamond as collateral a long time ago.\
        I haven't been able to redirect the portal since then.\""
        state put hero-crystal intro
        puts {}
        return portalRoom
    }

    proc basicPortal {} {
        puts "\"Of course.\""
        puts "Atheena activates the portal device."
        puts {}
        state put subspace-portal river
        return portalRoom
    }

}
