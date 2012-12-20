package retrobot

class DiscussionItemService {

    def createDiscussionItem(content, retroId){
        def retro = Retrospective.findById(retroId)

        if(retro){
            def item = new DiscussionItem(content: content)
            retro.addToDiscussionItems(item)
            item.number = findHighestDiscussionItemNumberInRetro(retro) + 1
            retro.save()
            return item
        }
    }

    private int findHighestDiscussionItemNumberInRetro(Retrospective retro) {
        // race condition - need better way in the long run
        retro.getDiscussionItems().max({i -> i.number})?.number ?: 0
    }
}
