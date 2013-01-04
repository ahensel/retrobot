package retrobot

import javax.servlet.http.HttpServletResponse

class DiscussionItemController {

    def discussionItemService

    def edit() {
        def discussionItem = DiscussionItem.findById(params.id)
        if (!discussionItem) {
            render "error"
            return
        }
        [discussionItem: discussionItem]
    }

    def save() {
        def discussionItem = new DiscussionItem(params)
        discussionItem.save()
        redirect(controller: 'retrospective', action: 'show', id: discussionItem.retrospective.id)
    }

    def update() {
        def discussionItem = DiscussionItem.findById(params.id)
        discussionItem.properties = params
        discussionItem.save()
        redirect(controller: 'retrospective', action: 'show', id: discussionItem.retrospective.id)
    }

    def create(){
        def discussionItem = discussionItemService.createDiscussionItem(params.newRetroItemText, params.retroId, params.classification)

        render(template:"discussionItem", bean: discussionItem)
    }

    def delete(){
        def discussionItem = DiscussionItem.findById(params.id)

        if (!discussionItem){
            render status: HttpServletResponse.SC_BAD_REQUEST
        } else{
            def retroID = discussionItem.retrospective.id
            discussionItem.actionItems.each{discussionItem.retrospective.removeFromRetroItems(it)}
            discussionItem.retrospective.removeFromRetroItems(discussionItem)
            discussionItem.delete(flush:true)
            redirect(controller: 'retrospective', action: 'show', id: retroID)
        }
    }

    def addActionItem(){
        def discussionItem = DiscussionItem.findById(params.id)
        discussionItem.addToActionItems(params.actionItem)
    }
}

