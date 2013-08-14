package retrobot

class Retrospective {

    static belongsTo = [project: Project]

    List retroItems
    static hasMany = [retroItems: RetroItem, actionItems: ActionItem]
    Boolean isActive
    String name
    int number

    static DiscussionItemClassifications = [
            [id:1, value:'Worked well'],
            [id:2, value:'Needs improvement'],
            [id:3, value:'Puzzles us']
    ]

    static constraints = {
    }
}
