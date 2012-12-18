package retrobot

import org.springframework.dao.DataIntegrityViolationException
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

    def delete(){
        def discussionItem = DiscussionItem.findById(params.id)

        if (!discussionItem){
            render status: HttpServletResponse.SC_BAD_REQUEST
        } else{
            def retroID = discussionItem.retrospective.id
            discussionItem.delete()
            redirect(controller: 'retrospective', action: 'show', id: retroID)
        }

    }
}

