package retrobot

class Retrospective {

    List discussionItems
<<<<<<< HEAD
    static hasMany = [discussionItems: DiscussionItem]
=======
    static hasMany = [discussionItems: DiscussionItem, actionItems: ActionItem]
>>>>>>> 134d7ddbefb28bc1e9391dd15821523706f22df8
    Boolean isActive

    static constraints = {
    }
}
