package retrobot

class DiscussionItem {

    String content
    static belongsTo = [retrospective: Retrospective]

    static constraints = {
        content nullable: false
    }
}
