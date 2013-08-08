package com.baoming.account

import org.springframework.dao.DataIntegrityViolationException
import grails.converters.JSON

class AdminController {
    def userService
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [adminInstanceList: Admin.list(params), adminInstanceTotal: Admin.count()]
    }

    def create() {
        [adminInstance: new Admin(params)]
    }

    def save() {
        def adminInstance = new Admin(params)
        def a = userService.saveAdmin(adminInstance)
        if (a.status == 0) {
            render(view: "create", model: [adminInstance: adminInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'admin.label', default: 'Admin'), adminInstance.id])
        redirect(action: "show", id: adminInstance.id)
    }

    def show(Long id) {
        def adminInstance = Admin.get(id)
        if (!adminInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'admin.label', default: 'Admin'), id])
            redirect(action: "list")
            return
        }

        [adminInstance: adminInstance]
    }

    def edit(Long id) {
        def adminInstance = Admin.get(id)
        if (!adminInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'admin.label', default: 'Admin'), id])
            redirect(action: "list")
            return
        }

        [adminInstance: adminInstance]
    }

    def update(Long id, Long version) {
        def adminInstance = Admin.get(id)
        if (!adminInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'admin.label', default: 'Admin'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (adminInstance.version > version) {
                adminInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'admin.label', default: 'Admin')] as Object[],
                        "Another user has updated this Admin while you were editing")
                render(view: "edit", model: [adminInstance: adminInstance])
                return
            }
        }

        adminInstance.properties = params

        if (!adminInstance.save(flush: true)) {
            render(view: "edit", model: [adminInstance: adminInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'admin.label', default: 'Admin'), adminInstance.id])
        redirect(action: "show", id: adminInstance.id)
    }

    def delete(Long id) {
        def adminInstance = Admin.get(id)
        if (!adminInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'admin.label', default: 'Admin'), id])
            if(params.act) {
                redirect(action: 'list')
                return
            }
            render(([status:0] as JSON) as String )
            return
        }

        try {
            userService.removeUser(adminInstance)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'admin.label', default: 'Admin'), id])
            if(params.act) {
                redirect(action: 'list')
                return
            }
            render(([status:1] as JSON) as String )
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'admin.label', default: 'Admin'), id])
            if(params.act) {
                redirect(action: 'list')
                return
            }
            render(([status:0] as JSON) as String )
        }
    }
}
