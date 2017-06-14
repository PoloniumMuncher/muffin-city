
namespace eval State {

    variable impl [dict create {*}{
        city-thug no
        stolen-good {}
        thug-card {Platinum Card}
        sa-coin no
        trial-crime no
        trial-reason {}
        janitor-door no
        been-to-prison no
        prison-guard no
        awaiting-bus no
        forest-river 0
        lobby-door no
        talked-to-johnny no
        johnny-quest no
        exercise-soul no
        talked-to-cipher no
        second-class-door no
        first-class-door no
        muffin-second no
        motel-room no
        inn-room no
        heard-science no
        butler-game no
        talked-to-louis no
        jumped-into-fire no
    }]

    proc get {args} {
        variable impl
        dict get $impl {*}$args
    }

    proc put {args} {
        variable impl
        dict set impl {*}$args
    }

    proc all {} {
        variable impl
        return $impl
    }

    namespace export get put all

    namespace ensemble create -command ::state

}