package retrobot



import org.junit.*
import grails.test.mixin.*

@TestFor(RetrospectiveController)
@Mock(Retrospective)
class RetrospectiveControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/retrospective/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.retrospectiveInstanceList.size() == 0
        assert model.retrospectiveInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.retrospectiveInstance != null
    }

    void testSave() {
        controller.save()

        assert model.retrospectiveInstance != null
        assert view == '/retrospective/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/retrospective/show/1'
        assert controller.flash.message != null
        assert Retrospective.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/retrospective/list'

        populateValidParams(params)
        def retrospective = new Retrospective(params)

        assert retrospective.save() != null

        params.id = retrospective.id

        def model = controller.show()

        assert model.retrospectiveInstance == retrospective
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/retrospective/list'

        populateValidParams(params)
        def retrospective = new Retrospective(params)

        assert retrospective.save() != null

        params.id = retrospective.id

        def model = controller.edit()

        assert model.retrospectiveInstance == retrospective
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/retrospective/list'

        response.reset()

        populateValidParams(params)
        def retrospective = new Retrospective(params)

        assert retrospective.save() != null

        // test invalid parameters in update
        params.id = retrospective.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/retrospective/edit"
        assert model.retrospectiveInstance != null

        retrospective.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/retrospective/show/$retrospective.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        retrospective.clearErrors()

        populateValidParams(params)
        params.id = retrospective.id
        params.version = -1
        controller.update()

        assert view == "/retrospective/edit"
        assert model.retrospectiveInstance != null
        assert model.retrospectiveInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/retrospective/list'

        response.reset()

        populateValidParams(params)
        def retrospective = new Retrospective(params)

        assert retrospective.save() != null
        assert Retrospective.count() == 1

        params.id = retrospective.id

        controller.delete()

        assert Retrospective.count() == 0
        assert Retrospective.get(retrospective.id) == null
        assert response.redirectedUrl == '/retrospective/list'
    }
}
