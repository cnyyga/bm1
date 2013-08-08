package com.baoming

import org.springframework.dao.DataIntegrityViolationException
import grails.converters.JSON

class PoliticalStatusController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [politicalStatusInstanceList: PoliticalStatus.list(params), politicalStatusInstanceTotal: PoliticalStatus.count()]
    }

    def create() {
        [politicalStatusInstance: new PoliticalStatus(params)]
    }

    def save() {
        def politicalStatusInstance = new PoliticalStatus(params)
        if (!politicalStatusInstance.save(flush: true)) {
            render(view: "create", model: [politicalStatusInstance: politicalStatusInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'politicalStatus.label', default: 'PoliticalStatus'), politicalStatusInstance.id])
        redirect(action: "show", id: politicalStatusInstance.id)
    }

    def show(Long id) {
        def politicalStatusInstance = PoliticalStatus.get(id)
        if (!politicalStatusInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'politicalStatus.label', default: 'PoliticalStatus'), id])
            redirect(action: "list")
            return
        }

        [politicalStatusInstance: politicalStatusInstance]
    }

    def edit(Long id) {
        def politicalStatusInstance = PoliticalStatus.get(id)
        if (!politicalStatusInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'politicalStatus.label', default: 'PoliticalStatus'), id])
            redirect(action: "list")
            return
        }

        [politicalStatusInstance: politicalStatusInstance]
    }

    def update(Long id, Long version) {
        def politicalStatusInstance = PoliticalStatus.get(id)
        if (!politicalStatusInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'politicalStatus.label', default: 'PoliticalStatus'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (politicalStatusInstance.version > version) {
                politicalStatusInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'politicalStatus.label', default: 'PoliticalStatus')] as Object[],
                        "Another user has updated this PoliticalStatus while you were editing")
                render(view: "edit", model: [politicalStatusInstance: politicalStatusInstance])
                return
            }
        }

        politicalStatusInstance.properties = params

        if (!politicalStatusInstance.save(flush: true)) {
            render(view: "edit", model: [politicalStatusInstance: politicalStatusInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'politicalStatus.label', default: 'PoliticalStatus'), politicalStatusInstance.id])
        redirect(action: "show", id: politicalStatusInstance.id)
    }

    def delete(Long id) {
        def politicalStatusInstance = PoliticalStatus.get(id)
        if (!politicalStatusInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'politicalStatus.label', default: 'PoliticalStatus'), id])
            if(params.act) {
                redirect(action: 'list')
                return
            }
            render(([status:0] as JSON) as String )
            return
        }

        try {
            politicalStatusInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'politicalStatus.label', default: 'PoliticalStatus'), id])
            if(params.act) {
                redirect(action: 'list')
                return
            }
            render(([status:1] as JSON) as String )
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'politicalStatus.label', default: 'PoliticalStatus'), id])
            if(params.act) {
                redirect(action: 'list')
                return
            }
            render(([status:0] as JSON) as String )
        }
    }
}
