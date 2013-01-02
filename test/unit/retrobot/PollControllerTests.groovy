package retrobot



import org.junit.*
import grails.test.mixin.*

@TestFor(PollController)
@Mock(Poll)
class PollControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/poll/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.pollInstanceList.size() == 0
        assert model.pollInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.pollInstance != null
    }

    void testSave() {
        controller.save()

        assert model.pollInstance != null
        assert view == '/poll/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/poll/show/1'
        assert controller.flash.message != null
        assert Poll.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/poll/list'

        populateValidParams(params)
        def poll = new Poll(params)

        assert poll.save() != null

        params.id = poll.id

        def model = controller.show()

        assert model.pollInstance == poll
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/poll/list'

        populateValidParams(params)
        def poll = new Poll(params)

        assert poll.save() != null

        params.id = poll.id

        def model = controller.edit()

        assert model.pollInstance == poll
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/poll/list'

        response.reset()

        populateValidParams(params)
        def poll = new Poll(params)

        assert poll.save() != null

        // test invalid parameters in update
        params.id = poll.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/poll/edit"
        assert model.pollInstance != null

        poll.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/poll/show/$poll.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        poll.clearErrors()

        populateValidParams(params)
        params.id = poll.id
        params.version = -1
        controller.update()

        assert view == "/poll/edit"
        assert model.pollInstance != null
        assert model.pollInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/poll/list'

        response.reset()

        populateValidParams(params)
        def poll = new Poll(params)

        assert poll.save() != null
        assert Poll.count() == 1

        params.id = poll.id

        controller.delete()

        assert Poll.count() == 0
        assert Poll.get(poll.id) == null
        assert response.redirectedUrl == '/poll/list'
    }
}
