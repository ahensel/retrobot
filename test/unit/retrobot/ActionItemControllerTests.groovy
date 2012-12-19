package retrobot



import org.junit.*
import grails.test.mixin.*

@TestFor(ActionItemController)
@Mock(ActionItem)
class ActionItemControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/actionItem/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.actionItemInstanceList.size() == 0
        assert model.actionItemInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.actionItemInstance != null
    }

    void testSave() {
        controller.save()

        assert model.actionItemInstance != null
        assert view == '/actionItem/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/actionItem/show/1'
        assert controller.flash.message != null
        assert ActionItem.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/actionItem/list'

        populateValidParams(params)
        def actionItem = new ActionItem(params)

        assert actionItem.save() != null

        params.id = actionItem.id

        def model = controller.show()

        assert model.actionItemInstance == actionItem
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/actionItem/list'

        populateValidParams(params)
        def actionItem = new ActionItem(params)

        assert actionItem.save() != null

        params.id = actionItem.id

        def model = controller.edit()

        assert model.actionItemInstance == actionItem
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/actionItem/list'

        response.reset()

        populateValidParams(params)
        def actionItem = new ActionItem(params)

        assert actionItem.save() != null

        // test invalid parameters in update
        params.id = actionItem.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/actionItem/edit"
        assert model.actionItemInstance != null

        actionItem.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/actionItem/show/$actionItem.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        actionItem.clearErrors()

        populateValidParams(params)
        params.id = actionItem.id
        params.version = -1
        controller.update()

        assert view == "/actionItem/edit"
        assert model.actionItemInstance != null
        assert model.actionItemInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/actionItem/list'

        response.reset()

        populateValidParams(params)
        def actionItem = new ActionItem(params)

        assert actionItem.save() != null
        assert ActionItem.count() == 1

        params.id = actionItem.id

        controller.delete()

        assert ActionItem.count() == 0
        assert ActionItem.get(actionItem.id) == null
        assert response.redirectedUrl == '/actionItem/list'
    }
}
