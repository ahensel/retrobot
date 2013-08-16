package retrobot

import org.springframework.dao.DataIntegrityViolationException

import javax.servlet.http.HttpServletResponse

class ActionItemController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def create() {
        def discussionItem = DiscussionItem.findById(params.discussionId)
        [actionItemInstance: new ActionItem(params), discussionItem: discussionItem ]
    }

    def save() {
        def actionItem = new ActionItem(params)
        def discussionItem = DiscussionItem.findById(params.discussionItemId)
        discussionItem.addToActionItems(actionItem)
        discussionItem.retrospective.addToActionItems(actionItem)
        discussionItem.retrospective.save()

        redirect(controller: "retrospective", action: "show", params: [id: discussionItem.retrospective.id, project: discussionItem.retrospective.project.id])
    }

    def edit() {
        def actionItem = ActionItem.get(params.id)
        if (!actionItem) {
            render "error"
            return
        }
        [actionItemInstance: actionItem]
    }

    def update() {
        def actionItem = ActionItem.findById(params.id)
        actionItem.properties = params
        actionItem.save()
        redirect(controller: 'retrospective', action: 'show', params: [id: actionItem.retrospective.id, project: actionItem.retrospective.project.id])
    }

    def delete(){
        def actionItem = ActionItem.findById(params.id)

        if (!actionItem){
            render status: HttpServletResponse.SC_BAD_REQUEST
        } else{
            def retroID = actionItem.retrospective.id
            def projectID = actionItem.retrospective.project.id
            actionItem.retrospective.removeFromActionItems(actionItem)
            actionItem.discussionItem.removeFromActionItems(actionItem)
            actionItem.delete(flush:true)
            redirect(controller: 'retrospective', action: 'show', params: [id: retroID, project: projectID])
        }
    }
}
