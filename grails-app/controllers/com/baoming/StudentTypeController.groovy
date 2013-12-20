package com.baoming

import org.springframework.dao.DataIntegrityViolationException
import grails.converters.JSON

class StudentTypeController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
    def studentTypeService
    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [studentTypeInstanceList: StudentType.list(params), studentTypeInstanceTotal: StudentType.count()]
    }

    def create() {
        [studentTypeInstance: new StudentType(params)]
    }

    def save() {
        def studentTypeInstance = new StudentType(params)
        if (!studentTypeInstance.save(flush: true)) {
            render(view: "create", model: [studentTypeInstance: studentTypeInstance])
            return
        }
        studentTypeService.clearStudentTypes()
        flash.message = message(code: 'default.created.message', args: [message(code: 'studentType.label', default: 'StudentType'), studentTypeInstance.id])
        redirect(action: "show", id: studentTypeInstance.id)
    }

    def show(Long id) {
        def studentTypeInstance = StudentType.get(id)
        if (!studentTypeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'studentType.label', default: 'StudentType'), id])
            redirect(action: "list")
            return
        }

        [studentTypeInstance: studentTypeInstance]
    }

    def edit(Long id) {
        def studentTypeInstance = StudentType.get(id)
        if (!studentTypeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'studentType.label', default: 'StudentType'), id])
            redirect(action: "list")
            return
        }

        [studentTypeInstance: studentTypeInstance]
    }

    def update(Long id, Long version) {
        def studentTypeInstance = StudentType.get(id)
        if (!studentTypeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'studentType.label', default: 'StudentType'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (studentTypeInstance.version > version) {
                studentTypeInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'studentType.label', default: 'StudentType')] as Object[],
                        "Another user has updated this StudentType while you were editing")
                render(view: "edit", model: [studentTypeInstance: studentTypeInstance])
                return
            }
        }

        studentTypeInstance.properties = params

        if (!studentTypeInstance.save(flush: true)) {
            render(view: "edit", model: [studentTypeInstance: studentTypeInstance])
            return
        }
        studentTypeService.clearStudentTypes()
        flash.message = message(code: 'default.updated.message', args: [message(code: 'studentType.label', default: 'StudentType'), studentTypeInstance.id])
        redirect(action: "show", id: studentTypeInstance.id)
    }

    def delete(Long id) {
        def studentTypeInstance = StudentType.get(id)
        if (!studentTypeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'studentType.label', default: 'StudentType'), id])
            if(params.act) {
                redirect(action: 'list')
                return
            }
            render(([status:0] as JSON) as String )
            return
        }

        try {
            studentTypeInstance.delete(flush: true)
            studentTypeService.clearStudentTypes()
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'studentType.label', default: 'StudentType'), id])
            if(params.act) {
                redirect(action: 'list')
                return
            }
            render(([status:1] as JSON) as String )
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'studentType.label', default: 'StudentType'), id])
            if(params.act) {
                redirect(action: 'list')
                return
            }
            render(([status:0] as JSON) as String )
        }
    }
}
