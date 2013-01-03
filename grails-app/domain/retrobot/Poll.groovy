package retrobot

class Poll extends RetroItem {
    static hasMany = [pollItems: PollItem]
    Boolean isOpen
}
