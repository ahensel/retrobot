package retrobot

class Poll {
    static belongsTo = [retrospective: Retrospective]
    static hasMany = [pollItems: PollItem]
    String content

    static constraints = {
    }
}
