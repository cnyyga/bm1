package com.baoming.account

import org.springframework.dao.DataIntegrityViolationException
import grails.converters.JSON

class FinanceController {
    def userService
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [financeInstanceList: Finance.list(params), financeInstanceTotal: Finance.count()]
    }

    def create() {
        [financeInstance: new Finance(params)]
    }

    def save() {
        def financeInstance = new Finance(params)
        def a = userService.saveFinance(financeInstance)
        if (a.status == 0) {
            render(view: "create", model: [adminInstance: financeInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'finance.label', default: 'Finance'), financeInstance.id])
        redirect(action: "show", id: financeInstance.id)
    }

    def show(Long id) {
        def financeInstance = Finance.get(id)
        if (!financeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'finance.label', default: 'Finance'), id])
            redirect(action: "list")
            return
        }

        [financeInstance: financeInstance]
    }

    def edit(Long id) {
        def financeInstance = Finance.get(id)
        if (!financeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'finance.label', default: 'Finance'), id])
            redirect(action: "list")
            return
        }

        [financeInstance: financeInstance]
    }

    def update(Long id, Long version) {
        def financeInstance = Finance.get(id)
        if (!financeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'finance.label', default: 'Finance'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (financeInstance.version > version) {
                financeInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'finance.label', default: 'Finance')] as Object[],
                        "Another user has updated this Finance while you were editing")
                render(view: "edit", model: [financeInstance: financeInstance])
                return
            }
        }

        financeInstance.properties = params

        if (!financeInstance.save(flush: true)) {
            render(view: "edit", model: [financeInstance: financeInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'finance.label', default: 'Finance'), financeInstance.id])
        redirect(action: "show", id: financeInstance.id)
    }

    def delete(Long id) {
        def financeInstance = Finance.get(id)
        if (!financeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'finance.label', default: 'Finance'), id])
            if(params.act) {
                redirect(action: 'list')
                return
            }
            render(([status:0] as JSON) as String )
            return
        }

        try {
            userService.removeUser(financeInstance)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'finance.label', default: 'Finance'), id])
            if(params.act) {
                redirect(action: 'list')
                return
            }
            render(([status:1] as JSON) as String )
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'finance.label', default: 'Finance'), id])
            if(params.act) {
                redirect(action: 'list')
                return
            }
            render(([status:0] as JSON) as String )
        }
    }
}
