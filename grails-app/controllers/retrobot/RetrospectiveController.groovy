package retrobot

class RetrospectiveController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def show() {
        def retro = null
        def project = Project.findById(params.project)

        if (params.id) {
            retro = Retrospective.findById(params.id)
        }
        else {
            retro = Retrospective.findByProjectAndIsActive(project, true)

            if (retro == null) {
                retro = new Retrospective(retroItems: [], isActive: true)
                project.addToRetrospectives(retro)
                retro.save()
            }
        }

        def previousRetros = Retrospective.findAllByProjectAndIsActive(project, false)

        [retro: retro, previousRetros: previousRetros]
    }

    def close() {
        def oldRetro = Retrospective.findById(params.retroId)
        oldRetro.isActive = false
        oldRetro.save()

        def newRetro = new Retrospective(retroItems: [], isActive: true)
        oldRetro.project.addToRetrospectives(newRetro)
        newRetro.save()

        copyRecurringRetroItems(oldRetro, newRetro)

        redirect([action: "show", params: [project: oldRetro.project.id]])
    }

    private def copyRecurringRetroItems(oldRetro, newRetro) {
        int num = 1;
        oldRetro.getRetroItems().findAll {i -> i.isRecurring}.each {i ->
            if (i instanceof DiscussionItem) {
                def newDiscussionItem = new DiscussionItem(content: i.content, isRecurring: i.isRecurring, classification: i.classification, number: num++)
                newRetro.addToRetroItems(newDiscussionItem)
            }
            else if (i instanceof Poll) {
                def newPoll = new Poll(content: i.content, isRecurring: i.isRecurring, pollItems: [], number: num++)
                i.pollItems.each { pi ->
                    def newPollItem = new PollItem(content: pi.content, votes: 0)
                    newPoll.addToPollItems(newPollItem)
                }
                newRetro.addToRetroItems(newPoll)
            }
        }
        newRetro.save()
    }


//
//    def index() {
//        redirect(action: "list", params: params)
//    }
//
//    def list(Integer max) {
//        params.max = Math.min(max ?: 10, 100)
//        [retrospectiveInstanceList: Retrospective.list(params), retrospectiveInstanceTotal: Retrospective.count()]
//    }
//
//    def create() {
//        [retrospectiveInstance: new Retrospective(params)]
//    }
//
//    def save() {
//        def retrospectiveInstance = new Retrospective(params)
//        if (!retrospectiveInstance.save(flush: true)) {
//            render(view: "create", model: [retrospectiveInstance: retrospectiveInstance])
//            return
//        }
//
//        flash.message = message(code: 'default.created.message', args: [message(code: 'retrospective.label', default: 'Retrospective'), retrospectiveInstance.id])
//        redirect(action: "show", id: retrospectiveInstance.id)
//    }
//
//    def show(Long id) {
//        def retrospectiveInstance = Retrospective.get(id)
//        if (!retrospectiveInstance) {
//            flash.message = message(code: 'default.not.found.message', args: [message(code: 'retrospective.label', default: 'Retrospective'), id])
//            redirect(action: "list")
//            return
//        }
//
//        [retrospectiveInstance: retrospectiveInstance]
//    }
//
//    def edit(Long id) {
//        def retrospectiveInstance = Retrospective.get(id)
//        if (!retrospectiveInstance) {
//            flash.message = message(code: 'default.not.found.message', args: [message(code: 'retrospective.label', default: 'Retrospective'), id])
//            redirect(action: "list")
//            return
//        }
//
//        [retrospectiveInstance: retrospectiveInstance]
//    }
//
//    def update(Long id, Long version) {
//        def retrospectiveInstance = Retrospective.get(id)
//        if (!retrospectiveInstance) {
//            flash.message = message(code: 'default.not.found.message', args: [message(code: 'retrospective.label', default: 'Retrospective'), id])
//            redirect(action: "list")
//            return
//        }
//
//        if (version != null) {
//            if (retrospectiveInstance.version > version) {
//                retrospectiveInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
//                          [message(code: 'retrospective.label', default: 'Retrospective')] as Object[],
//                          "Another user has updated this Retrospective while you were editing")
//                render(view: "edit", model: [retrospectiveInstance: retrospectiveInstance])
//                return
//            }
//        }
//
//        retrospectiveInstance.properties = params
//
//        if (!retrospectiveInstance.save(flush: true)) {
//            render(view: "edit", model: [retrospectiveInstance: retrospectiveInstance])
//            return
//        }
//
//        flash.message = message(code: 'default.updated.message', args: [message(code: 'retrospective.label', default: 'Retrospective'), retrospectiveInstance.id])
//        redirect(action: "show", id: retrospectiveInstance.id)
//    }
//
//    def delete(Long id) {
//        def retrospectiveInstance = Retrospective.get(id)
//        if (!retrospectiveInstance) {
//            flash.message = message(code: 'default.not.found.message', args: [message(code: 'retrospective.label', default: 'Retrospective'), id])
//            redirect(action: "list")
//            return
//        }
//
//        try {
//            retrospectiveInstance.delete(flush: true)
//            flash.message = message(code: 'default.deleted.message', args: [message(code: 'retrospective.label', default: 'Retrospective'), id])
//            redirect(action: "list")
//        }
//        catch (DataIntegrityViolationException e) {
//            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'retrospective.label', default: 'Retrospective'), id])
//            redirect(action: "show", id: id)
//        }
//    }
}
