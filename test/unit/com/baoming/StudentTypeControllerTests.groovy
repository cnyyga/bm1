package com.baoming



import org.junit.*
import grails.test.mixin.*

@TestFor(StudentTypeController)
@Mock(StudentType)
class StudentTypeControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/studentType/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.studentTypeInstanceList.size() == 0
        assert model.studentTypeInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.studentTypeInstance != null
    }

    void testSave() {
        controller.save()

        assert model.studentTypeInstance != null
        assert view == '/studentType/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/studentType/show/1'
        assert controller.flash.message != null
        assert StudentType.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/studentType/list'

        populateValidParams(params)
        def studentType = new StudentType(params)

        assert studentType.save() != null

        params.id = studentType.id

        def model = controller.show()

        assert model.studentTypeInstance == studentType
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/studentType/list'

        populateValidParams(params)
        def studentType = new StudentType(params)

        assert studentType.save() != null

        params.id = studentType.id

        def model = controller.edit()

        assert model.studentTypeInstance == studentType
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/studentType/list'

        response.reset()

        populateValidParams(params)
        def studentType = new StudentType(params)

        assert studentType.save() != null

        // test invalid parameters in update
        params.id = studentType.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/studentType/edit"
        assert model.studentTypeInstance != null

        studentType.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/studentType/show/$studentType.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        studentType.clearErrors()

        populateValidParams(params)
        params.id = studentType.id
        params.version = -1
        controller.update()

        assert view == "/studentType/edit"
        assert model.studentTypeInstance != null
        assert model.studentTypeInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/studentType/list'

        response.reset()

        populateValidParams(params)
        def studentType = new StudentType(params)

        assert studentType.save() != null
        assert StudentType.count() == 1

        params.id = studentType.id

        controller.delete()

        assert StudentType.count() == 0
        assert StudentType.get(studentType.id) == null
        assert response.redirectedUrl == '/studentType/list'
    }
}
