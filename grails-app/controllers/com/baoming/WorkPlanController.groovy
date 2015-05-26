package com.baoming

import org.springframework.dao.DataIntegrityViolationException

class WorkPlanController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [workPlanInstanceList: WorkPlan.list(params), workPlanInstanceTotal: WorkPlan.count()]
    }

    def create() {
        [workPlanInstance: new WorkPlan(params)]
    }

    def save() {
        def workPlanInstance = new WorkPlan(params)
        if (!workPlanInstance.save(flush: true)) {
            render(view: "create", model: [workPlanInstance: workPlanInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'workPlan.label', default: 'WorkPlan'), workPlanInstance.id])
        redirect(action: "show", id: workPlanInstance.id)
    }

    def show(Long id) {
        def workPlanInstance = WorkPlan.get(id)
        if (!workPlanInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'workPlan.label', default: 'WorkPlan'), id])
            redirect(action: "list")
            return
        }

        [workPlanInstance: workPlanInstance]
    }

    def edit(Long id) {
        def workPlanInstance = WorkPlan.get(id)
        if (!workPlanInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'workPlan.label', default: 'WorkPlan'), id])
            redirect(action: "list")
            return
        }

        [workPlanInstance: workPlanInstance]
    }

    def update(Long id, Long version) {
        def workPlanInstance = WorkPlan.get(id)
        if (!workPlanInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'workPlan.label', default: 'WorkPlan'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (workPlanInstance.version > version) {
                workPlanInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'workPlan.label', default: 'WorkPlan')] as Object[],
                        "Another user has updated this WorkPlan while you were editing")
                render(view: "edit", model: [workPlanInstance: workPlanInstance])
                return
            }
        }

        workPlanInstance.properties = params

        if (!workPlanInstance.save(flush: true)) {
            render(view: "edit", model: [workPlanInstance: workPlanInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'workPlan.label', default: 'WorkPlan'), workPlanInstance.id])
        redirect(action: "show", id: workPlanInstance.id)
    }

    def delete(Long id) {
        def workPlanInstance = WorkPlan.get(id)
        if (!workPlanInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'workPlan.label', default: 'WorkPlan'), id])
            redirect(action: "list")
            return
        }

        try {
            workPlanInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'workPlan.label', default: 'WorkPlan'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'workPlan.label', default: 'WorkPlan'), id])
            redirect(action: "show", id: id)
        }
    }
}
