package retrobot

class DiscussionItemService {

    def createDiscussionItem(content, retroId, classification){
        def retro = Retrospective.findById(retroId)

        if(retro){
            def item = new DiscussionItem(content: content, classification: classification)
            retro.addToRetroItems(item)
            item.number = findHighestDiscussionItemNumberInRetro(retro) + 1
            retro.save()
            return item
        }
    }

    private int findHighestDiscussionItemNumberInRetro(Retrospective retro) {
        // race condition - need better way in the long run
        retro.getRetroItems().max({i -> i.number})?.number ?: 0
    }
}
