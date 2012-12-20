package retrobot

class DiscussionItemService {

    def createDiscussionItem(content, retroId){
        def retro = Retrospective.findById(retroId)

        if(retro){
            def item = new DiscussionItem(content: content)
            retro.addToDiscussionItems(item)
<<<<<<< HEAD
=======
            item.number = findHighestDiscussionItemNumberInRetro(retro) + 1
>>>>>>> 134d7ddbefb28bc1e9391dd15821523706f22df8
            retro.save()
            return item
        }
    }
<<<<<<< HEAD
=======

    private int findHighestDiscussionItemNumberInRetro(Retrospective retro) {
        // race condition - need better way in the long run
        retro.getDiscussionItems().max({i -> i.number})?.number ?: 0
    }
>>>>>>> 134d7ddbefb28bc1e9391dd15821523706f22df8
}
