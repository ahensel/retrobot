package retrobot

class ActionItem extends RetroItem {

    static belongsTo = [retrospective: Retrospective, discussionItem: DiscussionItem]

    String content
    String[] owners

    static constraints = {
    }
}
