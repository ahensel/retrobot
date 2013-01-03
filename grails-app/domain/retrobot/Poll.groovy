package retrobot

class Poll extends RetroItem {

//    String content
//    static belongsTo = [retrospective: Retrospective]
//    int number
//    boolean isRecurring
//
//    static constraints = {
//        content nullable: false
//    }



    static hasMany = [pollItems: PollItem]
    Boolean isOpen
}
