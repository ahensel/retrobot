package retrobot



import org.junit.*
import grails.test.mixin.*

@TestFor(DiscussionItemController)
@Mock(DiscussionItem)
class DiscussionItemControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/discussionItem/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.discussionItemInstanceList.size() == 0
        assert model.discussionItemInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.discussionItemInstance != null
    }

    void testSave() {
        controller.save()

        assert model.discussionItemInstance != null
        assert view == '/discussionItem/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/discussionItem/show/1'
        assert controller.flash.message != null
        assert DiscussionItem.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/discussionItem/list'

        populateValidParams(params)
        def discussionItem = new DiscussionItem(params)

        assert discussionItem.save() != null

        params.id = discussionItem.id

        def model = controller.show()

        assert model.discussionItemInstance == discussionItem
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/discussionItem/list'

        populateValidParams(params)
        def discussionItem = new DiscussionItem(params)

        assert discussionItem.save() != null

        params.id = discussionItem.id

        def model = controller.edit()

        assert model.discussionItemInstance == discussionItem
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/discussionItem/list'

        response.reset()

        populateValidParams(params)
        def discussionItem = new DiscussionItem(params)

        assert discussionItem.save() != null

        // test invalid parameters in update
        params.id = discussionItem.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/discussionItem/edit"
        assert model.discussionItemInstance != null

        discussionItem.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/discussionItem/show/$discussionItem.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        discussionItem.clearErrors()

        populateValidParams(params)
        params.id = discussionItem.id
        params.version = -1
        controller.update()

        assert view == "/discussionItem/edit"
        assert model.discussionItemInstance != null
        assert model.discussionItemInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/discussionItem/list'

        response.reset()

        populateValidParams(params)
        def discussionItem = new DiscussionItem(params)

        assert discussionItem.save() != null
        assert DiscussionItem.count() == 1

        params.id = discussionItem.id

        controller.delete()

        assert DiscussionItem.count() == 0
        assert DiscussionItem.get(discussionItem.id) == null
        assert response.redirectedUrl == '/discussionItem/list'
    }
}
