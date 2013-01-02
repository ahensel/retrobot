package retrobot

class PollItem {
    String content
    Integer votes

    static belongsTo = [poll: Poll]
    static constraints = {
    }
}
