package com.baoming



import org.junit.*
import grails.test.mixin.*

@TestFor(NationController)
@Mock(Nation)
class NationControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/nation/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.nationInstanceList.size() == 0
        assert model.nationInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.nationInstance != null
    }

    void testSave() {
        controller.save()

        assert model.nationInstance != null
        assert view == '/nation/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/nation/show/1'
        assert controller.flash.message != null
        assert Nation.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/nation/list'

        populateValidParams(params)
        def nation = new Nation(params)

        assert nation.save() != null

        params.id = nation.id

        def model = controller.show()

        assert model.nationInstance == nation
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/nation/list'

        populateValidParams(params)
        def nation = new Nation(params)

        assert nation.save() != null

        params.id = nation.id

        def model = controller.edit()

        assert model.nationInstance == nation
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/nation/list'

        response.reset()

        populateValidParams(params)
        def nation = new Nation(params)

        assert nation.save() != null

        // test invalid parameters in update
        params.id = nation.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/nation/edit"
        assert model.nationInstance != null

        nation.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/nation/show/$nation.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        nation.clearErrors()

        populateValidParams(params)
        params.id = nation.id
        params.version = -1
        controller.update()

        assert view == "/nation/edit"
        assert model.nationInstance != null
        assert model.nationInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/nation/list'

        response.reset()

        populateValidParams(params)
        def nation = new Nation(params)

        assert nation.save() != null
        assert Nation.count() == 1

        params.id = nation.id

        controller.delete()

        assert Nation.count() == 0
        assert Nation.get(nation.id) == null
        assert response.redirectedUrl == '/nation/list'
    }
}
