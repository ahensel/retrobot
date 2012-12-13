package retrobot

class Retrospective {

    List discussionItems
    static hasMany = [discussionItems: DiscussionItem]
    Boolean isActive

    static constraints = {
    }
}
