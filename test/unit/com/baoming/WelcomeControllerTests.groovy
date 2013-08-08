package com.baoming



import org.junit.*
import grails.test.mixin.*

@TestFor(WelcomeController)
@Mock(Welcome)
class WelcomeControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/welcome/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.welcomeInstanceList.size() == 0
        assert model.welcomeInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.welcomeInstance != null
    }

    void testSave() {
        controller.save()

        assert model.welcomeInstance != null
        assert view == '/welcome/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/welcome/show/1'
        assert controller.flash.message != null
        assert Welcome.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/welcome/list'

        populateValidParams(params)
        def welcome = new Welcome(params)

        assert welcome.save() != null

        params.id = welcome.id

        def model = controller.show()

        assert model.welcomeInstance == welcome
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/welcome/list'

        populateValidParams(params)
        def welcome = new Welcome(params)

        assert welcome.save() != null

        params.id = welcome.id

        def model = controller.edit()

        assert model.welcomeInstance == welcome
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/welcome/list'

        response.reset()

        populateValidParams(params)
        def welcome = new Welcome(params)

        assert welcome.save() != null

        // test invalid parameters in update
        params.id = welcome.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/welcome/edit"
        assert model.welcomeInstance != null

        welcome.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/welcome/show/$welcome.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        welcome.clearErrors()

        populateValidParams(params)
        params.id = welcome.id
        params.version = -1
        controller.update()

        assert view == "/welcome/edit"
        assert model.welcomeInstance != null
        assert model.welcomeInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/welcome/list'

        response.reset()

        populateValidParams(params)
        def welcome = new Welcome(params)

        assert welcome.save() != null
        assert Welcome.count() == 1

        params.id = welcome.id

        controller.delete()

        assert Welcome.count() == 0
        assert Welcome.get(welcome.id) == null
        assert response.redirectedUrl == '/welcome/list'
    }
}
