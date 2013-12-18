package com.baoming



import org.junit.*
import grails.test.mixin.*

@TestFor(PreppyController)
@Mock(Preppy)
class PreppyControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/preppy/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.preppyInstanceList.size() == 0
        assert model.preppyInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.preppyInstance != null
    }

    void testSave() {
        controller.save()

        assert model.preppyInstance != null
        assert view == '/preppy/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/preppy/show/1'
        assert controller.flash.message != null
        assert Preppy.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/preppy/list'

        populateValidParams(params)
        def preppy = new Preppy(params)

        assert preppy.save() != null

        params.id = preppy.id

        def model = controller.show()

        assert model.preppyInstance == preppy
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/preppy/list'

        populateValidParams(params)
        def preppy = new Preppy(params)

        assert preppy.save() != null

        params.id = preppy.id

        def model = controller.edit()

        assert model.preppyInstance == preppy
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/preppy/list'

        response.reset()

        populateValidParams(params)
        def preppy = new Preppy(params)

        assert preppy.save() != null

        // test invalid parameters in update
        params.id = preppy.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/preppy/edit"
        assert model.preppyInstance != null

        preppy.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/preppy/show/$preppy.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        preppy.clearErrors()

        populateValidParams(params)
        params.id = preppy.id
        params.version = -1
        controller.update()

        assert view == "/preppy/edit"
        assert model.preppyInstance != null
        assert model.preppyInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/preppy/list'

        response.reset()

        populateValidParams(params)
        def preppy = new Preppy(params)

        assert preppy.save() != null
        assert Preppy.count() == 1

        params.id = preppy.id

        controller.delete()

        assert Preppy.count() == 0
        assert Preppy.get(preppy.id) == null
        assert response.redirectedUrl == '/preppy/list'
    }
}
