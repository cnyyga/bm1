package com.baoming

import org.springframework.dao.DataIntegrityViolationException
import grails.converters.JSON

class NationController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [nationInstanceList: Nation.list(params), nationInstanceTotal: Nation.count()]
    }

    def create() {
        [nationInstance: new Nation(params)]
    }

    def save() {
        def nationInstance = new Nation(params)
        if (!nationInstance.save(flush: true)) {
            render(view: "create", model: [nationInstance: nationInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'nation.label', default: 'Nation'), nationInstance.id])
        redirect(action: "show", id: nationInstance.id)
    }

    def show(Long id) {
        def nationInstance = Nation.get(id)
        if (!nationInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'nation.label', default: 'Nation'), id])
            redirect(action: "list")
            return
        }

        [nationInstance: nationInstance]
    }

    def edit(Long id) {
        def nationInstance = Nation.get(id)
        if (!nationInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'nation.label', default: 'Nation'), id])
            redirect(action: "list")
            return
        }

        [nationInstance: nationInstance]
    }

    def update(Long id, Long version) {
        def nationInstance = Nation.get(id)
        if (!nationInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'nation.label', default: 'Nation'), id])
            redirect(action: "list")
            return
        }

        nationInstance.properties = params

        if (!nationInstance.save(flush: true)) {
            render(view: "edit", model: [nationInstance: nationInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'nation.label', default: 'Nation'), nationInstance.id])
        redirect(action: "show", id: nationInstance.id)
    }

    def delete(Long id) {
        def nationInstance = Nation.get(id)
        if (!nationInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'nation.label', default: 'Nation'), id])
            if(params.act) {
                redirect(action: 'list')
                return
            }
            render(([status:0] as JSON) as String )
            return
        }

        try {
            nationInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'nation.label', default: 'Nation'), id])
            if(params.act) {
                redirect(action: 'list')
                return
            }
            render(([status:1] as JSON) as String )
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'nation.label', default: 'Nation'), id])
            if(params.act) {
                redirect(action: 'list')
                return
            }
            render(([status:0] as JSON) as String )
        }
    }
}
