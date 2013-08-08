package com.baoming



import org.junit.*
import grails.test.mixin.*

@TestFor(MiddleSchoolController)
@Mock(MiddleSchool)
class MiddleSchoolControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/middleSchool/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.middleSchoolInstanceList.size() == 0
        assert model.middleSchoolInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.middleSchoolInstance != null
    }

    void testSave() {
        controller.save()

        assert model.middleSchoolInstance != null
        assert view == '/middleSchool/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/middleSchool/show/1'
        assert controller.flash.message != null
        assert MiddleSchool.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/middleSchool/list'

        populateValidParams(params)
        def middleSchool = new MiddleSchool(params)

        assert middleSchool.save() != null

        params.id = middleSchool.id

        def model = controller.show()

        assert model.middleSchoolInstance == middleSchool
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/middleSchool/list'

        populateValidParams(params)
        def middleSchool = new MiddleSchool(params)

        assert middleSchool.save() != null

        params.id = middleSchool.id

        def model = controller.edit()

        assert model.middleSchoolInstance == middleSchool
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/middleSchool/list'

        response.reset()

        populateValidParams(params)
        def middleSchool = new MiddleSchool(params)

        assert middleSchool.save() != null

        // test invalid parameters in update
        params.id = middleSchool.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/middleSchool/edit"
        assert model.middleSchoolInstance != null

        middleSchool.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/middleSchool/show/$middleSchool.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        middleSchool.clearErrors()

        populateValidParams(params)
        params.id = middleSchool.id
        params.version = -1
        controller.update()

        assert view == "/middleSchool/edit"
        assert model.middleSchoolInstance != null
        assert model.middleSchoolInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/middleSchool/list'

        response.reset()

        populateValidParams(params)
        def middleSchool = new MiddleSchool(params)

        assert middleSchool.save() != null
        assert MiddleSchool.count() == 1

        params.id = middleSchool.id

        controller.delete()

        assert MiddleSchool.count() == 0
        assert MiddleSchool.get(middleSchool.id) == null
        assert response.redirectedUrl == '/middleSchool/list'
    }
}
