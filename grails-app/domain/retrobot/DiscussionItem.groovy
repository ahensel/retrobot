package retrobot

class DiscussionItem extends RetroItem {

//    String content
//    static belongsTo = [retrospective: Retrospective]
//    int number
//    boolean isRecurring
//
//    static constraints = {
//        content nullable: false
//    }


    static hasMany = [actionItems: ActionItem]
    int classification  // see Retrospective.DiscussionItemClassifications
}
