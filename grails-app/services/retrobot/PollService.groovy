package retrobot

class PollService {

    def createPoll(content, pollItems, retroId){
        def retro = Retrospective.findById(retroId)

        if (retro) {
            def poll = new Poll(content: content)
            pollItems.each {pollItemText ->
                poll.addToPollItems(new PollItem(content: pollItemText, votes: 0))
            }
            retro.addToRetroItems(poll)
            poll.number = findHighestRetroItemNumberInRetro(retro) + 1
            poll.isOpen = true
            retro.save()
            return poll
        }
    }

    private int findHighestRetroItemNumberInRetro(Retrospective retro) {
        // race condition - need better way in the long run
        retro.getRetroItems().max({i -> i.number})?.number ?: 0
    }
}
