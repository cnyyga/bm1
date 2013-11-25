package com.baoming

import org.springframework.dao.DataIntegrityViolationException

class PreppyController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [preppyInstanceList: Preppy.list(params), preppyInstanceTotal: Preppy.count()]
    }

    def create() {
        [preppyInstance: new Preppy(params)]
    }

    def save() {
        def preppyInstance = new Preppy(params)
        if (!preppyInstance.save(flush: true)) {
            render(view: "create", model: [preppyInstance: preppyInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'preppy.label', default: 'Preppy'), preppyInstance.id])
        redirect(action: "show", id: preppyInstance.id)
    }

    def show(Long id) {
        def preppyInstance = Preppy.get(id)
        if (!preppyInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'preppy.label', default: 'Preppy'), id])
            redirect(action: "list")
            return
        }

        [preppyInstance: preppyInstance]
    }

    def edit(Long id) {
        def preppyInstance = Preppy.get(id)
        if (!preppyInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'preppy.label', default: 'Preppy'), id])
            redirect(action: "list")
            return
        }

        [preppyInstance: preppyInstance]
    }

    def update(Long id, Long version) {
        def preppyInstance = Preppy.get(id)
        if (!preppyInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'preppy.label', default: 'Preppy'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (preppyInstance.version > version) {
                preppyInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'preppy.label', default: 'Preppy')] as Object[],
                        "Another user has updated this Preppy while you were editing")
                render(view: "edit", model: [preppyInstance: preppyInstance])
                return
            }
        }

        preppyInstance.properties = params

        if (!preppyInstance.save(flush: true)) {
            render(view: "edit", model: [preppyInstance: preppyInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'preppy.label', default: 'Preppy'), preppyInstance.id])
        redirect(action: "show", id: preppyInstance.id)
    }

    def delete(Long id) {
        def preppyInstance = Preppy.get(id)
        if (!preppyInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'preppy.label', default: 'Preppy'), id])
            redirect(action: "list")
            return
        }

        try {
            preppyInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'preppy.label', default: 'Preppy'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'preppy.label', default: 'Preppy'), id])
            redirect(action: "show", id: id)
        }
    }
}
