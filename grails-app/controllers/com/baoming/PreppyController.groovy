package com.baoming

import com.baoming.account.Role
import com.baoming.account.Teacher
import grails.converters.JSON
import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils
import org.springframework.dao.DataIntegrityViolationException

class PreppyController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
    def springSecurityService
    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        def userId = springSecurityService.authentication.principal?.id
        def name = params.name
        def list
        def total
        if (SpringSecurityUtils.ifAllGranted(Role.AUTHORITY_TEACHER)) {
             def teacher = Teacher.get(userId)
            list = Preppy.createCriteria().list(params) {
                eq('teacher',teacher)
                if(name) {
                    like('name',"%${name}%")
                }
            }
            total = Preppy.createCriteria().count {
                eq('teacher',teacher)
                if(name) {
                    like('name',"%${name}%")
                }
            }
        } else {
            list =  name?Preppy.findAllByNameLike("%${name}%",params):Preppy.list(params)
            total = name?Preppy.countByNameLike("%${name}%"):Preppy.count()
        }
        params.max = Math.min(max ?: 10, 100)
        [preppyInstanceList: list, preppyInstanceTotal: total]
    }

    def create() {
        [preppyInstance: new Preppy(params)]
    }

    def save() {
        def preppyInstance = new Preppy(params)
        def userId = springSecurityService.authentication.principal?.id
        if (SpringSecurityUtils.ifAllGranted(Role.AUTHORITY_TEACHER)) {
            def teacher = Teacher.get(userId)
            preppyInstance.teacher = teacher
        }

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
        def preppyInstance
        if (SpringSecurityUtils.ifAllGranted(Role.AUTHORITY_TEACHER)) {
            def userId = springSecurityService.authentication.principal?.id
            def teacher = Teacher.get(userId)
            preppyInstance.teacher = teacher
            preppyInstance = Preppy.findByIdAndTeacher(id,teacher)
        }else{
            preppyInstance = Preppy.get(id)
        }
        if (!preppyInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'preppy.label', default: 'Preppy'), id])
            if(params.act) {
                redirect(action: 'list')
                return
            }
            render(([status:0] as JSON) as String )
            return
        }

        try {
            preppyInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'preppy.label', default: 'Preppy'), id])
            if(params.act) {
                redirect(action: 'list')
                return
            }
            render(([status:1] as JSON) as String )
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'preppy.label', default: 'Preppy'), id])
            if(params.act) {
                redirect(action: 'list')
                return
            }
            render(([status:0] as JSON) as String )
        }
    }
}
