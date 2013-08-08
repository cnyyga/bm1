package com.baoming



import org.junit.*
import grails.test.mixin.*

@TestFor(PoliticalStatusController)
@Mock(PoliticalStatus)
class PoliticalStatusControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/politicalStatus/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.politicalStatusInstanceList.size() == 0
        assert model.politicalStatusInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.politicalStatusInstance != null
    }

    void testSave() {
        controller.save()

        assert model.politicalStatusInstance != null
        assert view == '/politicalStatus/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/politicalStatus/show/1'
        assert controller.flash.message != null
        assert PoliticalStatus.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/politicalStatus/list'

        populateValidParams(params)
        def politicalStatus = new PoliticalStatus(params)

        assert politicalStatus.save() != null

        params.id = politicalStatus.id

        def model = controller.show()

        assert model.politicalStatusInstance == politicalStatus
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/politicalStatus/list'

        populateValidParams(params)
        def politicalStatus = new PoliticalStatus(params)

        assert politicalStatus.save() != null

        params.id = politicalStatus.id

        def model = controller.edit()

        assert model.politicalStatusInstance == politicalStatus
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/politicalStatus/list'

        response.reset()

        populateValidParams(params)
        def politicalStatus = new PoliticalStatus(params)

        assert politicalStatus.save() != null

        // test invalid parameters in update
        params.id = politicalStatus.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/politicalStatus/edit"
        assert model.politicalStatusInstance != null

        politicalStatus.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/politicalStatus/show/$politicalStatus.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        politicalStatus.clearErrors()

        populateValidParams(params)
        params.id = politicalStatus.id
        params.version = -1
        controller.update()

        assert view == "/politicalStatus/edit"
        assert model.politicalStatusInstance != null
        assert model.politicalStatusInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/politicalStatus/list'

        response.reset()

        populateValidParams(params)
        def politicalStatus = new PoliticalStatus(params)

        assert politicalStatus.save() != null
        assert PoliticalStatus.count() == 1

        params.id = politicalStatus.id

        controller.delete()

        assert PoliticalStatus.count() == 0
        assert PoliticalStatus.get(politicalStatus.id) == null
        assert response.redirectedUrl == '/politicalStatus/list'
    }
}
