package retrobot

class ActionItem {

    static belongsTo = [retrospective: Retrospective, discussionItem: DiscussionItem]

    String content
    String[] owners

    static constraints = {
    }
}
