package com.baoming.account



import org.junit.*
import grails.test.mixin.*

@TestFor(FinanceController)
@Mock(Finance)
class FinanceControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/finance/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.financeInstanceList.size() == 0
        assert model.financeInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.financeInstance != null
    }

    void testSave() {
        controller.save()

        assert model.financeInstance != null
        assert view == '/finance/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/finance/show/1'
        assert controller.flash.message != null
        assert Finance.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/finance/list'

        populateValidParams(params)
        def finance = new Finance(params)

        assert finance.save() != null

        params.id = finance.id

        def model = controller.show()

        assert model.financeInstance == finance
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/finance/list'

        populateValidParams(params)
        def finance = new Finance(params)

        assert finance.save() != null

        params.id = finance.id

        def model = controller.edit()

        assert model.financeInstance == finance
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/finance/list'

        response.reset()

        populateValidParams(params)
        def finance = new Finance(params)

        assert finance.save() != null

        // test invalid parameters in update
        params.id = finance.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/finance/edit"
        assert model.financeInstance != null

        finance.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/finance/show/$finance.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        finance.clearErrors()

        populateValidParams(params)
        params.id = finance.id
        params.version = -1
        controller.update()

        assert view == "/finance/edit"
        assert model.financeInstance != null
        assert model.financeInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/finance/list'

        response.reset()

        populateValidParams(params)
        def finance = new Finance(params)

        assert finance.save() != null
        assert Finance.count() == 1

        params.id = finance.id

        controller.delete()

        assert Finance.count() == 0
        assert Finance.get(finance.id) == null
        assert response.redirectedUrl == '/finance/list'
    }
}
