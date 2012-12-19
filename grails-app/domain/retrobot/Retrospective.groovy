package retrobot

class Retrospective {

    List discussionItems
    static hasMany = [discussionItems: DiscussionItem, actionItems: ActionItem]
    Boolean isActive

    static constraints = {
    }
}
