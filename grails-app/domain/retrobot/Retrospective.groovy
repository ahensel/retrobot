package retrobot

class Retrospective {

    List discussionItems
    static hasMany = [discussionItems: DiscussionItem, actionItems: ActionItem]
    Boolean isActive

    static DiscussionItemClassifications = [
            [id:1, value:'Worked well'],
            [id:2, value:'Needs improvement'],
            [id:3, value:'Puzzles us']
    ]

    static constraints = {
    }
}
