package retrobot

import org.springframework.dao.DataIntegrityViolationException

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

        redirect(controller: "retrospective", action: "show", id: discussionItem.retrospective.id)
    }

    def edit(Long id) {
        def actionItemInstance = ActionItem.get(id)
        if (!actionItemInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'actionItem.label', default: 'ActionItem'), id])
            redirect(action: "list")
            return
        }

        [actionItemInstance: actionItemInstance]
    }

    def update(Long id, Long version) {
        def actionItemInstance = ActionItem.get(id)
        if (!actionItemInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'actionItem.label', default: 'ActionItem'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (actionItemInstance.version > version) {
                actionItemInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'actionItem.label', default: 'ActionItem')] as Object[],
                        "Another user has updated this ActionItem while you were editing")
                render(view: "edit", model: [actionItemInstance: actionItemInstance])
                return
            }
        }

        actionItemInstance.properties = params

        if (!actionItemInstance.save(flush: true)) {
            render(view: "edit", model: [actionItemInstance: actionItemInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'actionItem.label', default: 'ActionItem'), actionItemInstance.id])
        redirect(action: "show", id: actionItemInstance.id)
    }

    def delete(Long id) {
        def actionItemInstance = ActionItem.get(id)
        if (!actionItemInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'actionItem.label', default: 'ActionItem'), id])
            redirect(action: "list")
            return
        }

        try {
            actionItemInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'actionItem.label', default: 'ActionItem'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'actionItem.label', default: 'ActionItem'), id])
            redirect(action: "show", id: id)
        }
    }
}
