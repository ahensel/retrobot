package retrobot

class DiscussionItem extends RetroItem {
    static hasMany = [actionItems: ActionItem]
    int classification  // see Retrospective.DiscussionItemClassifications

    static constraints = {
        actionItems cascade: "all-delete-orphan"
    }
}
