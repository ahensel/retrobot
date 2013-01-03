package retrobot

abstract class RetroItem {

    String content
    static belongsTo = [retrospective: Retrospective]
    int number
    boolean isRecurring

    static constraints = {
        content nullable: false
    }
}
