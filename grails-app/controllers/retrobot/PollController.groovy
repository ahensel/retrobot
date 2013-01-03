package retrobot

class PollController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def create() {
        def poll = new Poll()
        poll.content = params.newRetroItemText
        for (def i = 0; i < (params.int('pollItemCount') ?: 0); i++){
            poll.addToPollItems(new PollItem(content: params."pollItem${i}", votes: 0))
        }

        def retro = Retrospective.findById(params.retroId)
        retro.addToRetroItems(poll)
        poll.number = findHighestRetroItemNumberInRetro(retro) + 1
        retro.save()

        render(template:"poll", bean: poll)
    }

    private int findHighestRetroItemNumberInRetro(Retrospective retro) {
        // race condition - need better way in the long run
        retro.getRetroItems().max({i -> i.number})?.number ?: 0
    }

    def save() {
        def pollInstance = new Poll(params)
        if (!pollInstance.save(flush: true)) {
            render(view: "create", model: [pollInstance: pollInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'poll.label', default: 'Poll'), pollInstance.id])
        redirect(action: "show", id: pollInstance.id)
    }
/*
    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [pollInstanceList: Poll.list(params), pollInstanceTotal: Poll.count()]
    }

    def create() {
        [pollInstance: new Poll(params)]
    }

    def save() {
        def pollInstance = new Poll(params)
        if (!pollInstance.save(flush: true)) {
            render(view: "create", model: [pollInstance: pollInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'poll.label', default: 'Poll'), pollInstance.id])
        redirect(action: "show", id: pollInstance.id)
    }

    def show(Long id) {
        def pollInstance = Poll.get(id)
        if (!pollInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'poll.label', default: 'Poll'), id])
            redirect(action: "list")
            return
        }

        [pollInstance: pollInstance]
    }

    def edit(Long id) {
        def pollInstance = Poll.get(id)
        if (!pollInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'poll.label', default: 'Poll'), id])
            redirect(action: "list")
            return
        }

        [pollInstance: pollInstance]
    }

    def update(Long id, Long version) {
        def pollInstance = Poll.get(id)
        if (!pollInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'poll.label', default: 'Poll'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (pollInstance.version > version) {
                pollInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'poll.label', default: 'Poll')] as Object[],
                        "Another user has updated this Poll while you were editing")
                render(view: "edit", model: [pollInstance: pollInstance])
                return
            }
        }

        pollInstance.properties = params

        if (!pollInstance.save(flush: true)) {
            render(view: "edit", model: [pollInstance: pollInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'poll.label', default: 'Poll'), pollInstance.id])
        redirect(action: "show", id: pollInstance.id)
    }

    def delete(Long id) {
        def pollInstance = Poll.get(id)
        if (!pollInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'poll.label', default: 'Poll'), id])
            redirect(action: "list")
            return
        }

        try {
            pollInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'poll.label', default: 'Poll'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'poll.label', default: 'Poll'), id])
            redirect(action: "show", id: id)
        }
    }
    */
}
