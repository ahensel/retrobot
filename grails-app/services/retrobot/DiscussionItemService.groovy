package retrobot

class DiscussionItemService {

    def createDiscussionItem(content, retroId){
        def retro = Retrospective.findById(retroId)

        if(retro){
            def item = new DiscussionItem(content: content)
            retro.addToDiscussionItems(item)
            retro.save()
            return item
        }
    }
}
