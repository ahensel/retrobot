package retrobot

class DiscussionItem {

    String content
<<<<<<< HEAD
    static belongsTo = [retrospective: Retrospective]
=======
    static hasMany = [actionItems: ActionItem]
    static belongsTo = [retrospective: Retrospective]
    int number
    boolean isRecurring
>>>>>>> 134d7ddbefb28bc1e9391dd15821523706f22df8

    static constraints = {
        content nullable: false
    }
}
