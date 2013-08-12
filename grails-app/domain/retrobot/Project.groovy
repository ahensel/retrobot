package retrobot

class Project {
    String name
    //other future attributes: Date and Time, purpose, creator, assigned facilitator,

    List retrospectives
    static hasMany = [retrospectives: Retrospective]

    static constraints = {
    }
}
