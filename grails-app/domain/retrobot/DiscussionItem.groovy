package retrobot

class DiscussionItem {

    String content
    static hasMany = [actionItems: ActionItem]
    static belongsTo = [retrospective: Retrospective]
    int number
    boolean isRecurring
    int classification  // see Retrospective.DiscussionItemClassifications

    static constraints = {
        content nullable: false
    }
}
