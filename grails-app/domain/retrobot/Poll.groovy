package retrobot

class Poll extends RetroItem {
    List pollItems
    static hasMany = [pollItems: PollItem]
    Boolean isOpen
}
