package com.baoming

import org.springframework.dao.DataIntegrityViolationException
import grails.converters.JSON

class PlanController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def planService

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [planInstanceList: Plan.list(params), planInstanceTotal: Plan.count()]
    }

    def create() {

        [planInstance: new Plan(params)]
    }

    def save() {
        def planInstance = new Plan(params)
        if (!planInstance.save(flush: true)) {
            render(view: "create", model: [planInstance: planInstance])
            return
        }
        def flgs = params.list('flg')
        if(flgs) {
            flgs.each {
                new PlanUse(flg: it as short,plan: planInstance).save()
            }
        }
        planService.clearPlans()
        flash.message = message(code: 'default.created.message', args: [message(code: 'plan.label', default: 'Plan'), planInstance.id])
        redirect(action: "show", id: planInstance.id)
    }

    def show(Long id) {
        def planInstance = Plan.get(id)
        if (!planInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'plan.label', default: 'Plan'), id])
            redirect(action: "list")
            return
        }

        [planInstance: planInstance]
    }

    def edit(Long id) {
        def planInstance = Plan.get(id)
        if (!planInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'plan.label', default: 'Plan'), id])
            redirect(action: "list")
            return
        }
        [planInstance: planInstance]
    }

    def update(Long id, Long version) {
        def planInstance = Plan.get(id)
        if (!planInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'plan.label', default: 'Plan'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (planInstance.version > version) {
                planInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'plan.label', default: 'Plan')] as Object[],
                        "Another user has updated this Plan while you were editing")
                render(view: "edit", model: [planInstance: planInstance])
                return
            }
        }

        planInstance.properties = params

        if (!planInstance.save(flush: true)) {
            render(view: "edit", model: [planInstance: planInstance])
            return
        }

        PlanUse.executeUpdate("delete PlanUse a where a.plan=?",[planInstance])
        def flgs = params.list('flg')
        if(flgs) {
            flgs.each {
                new PlanUse(flg: it as short,plan: planInstance).save()
            }
        }
        planService.clearPlans()
        flash.message = message(code: 'default.updated.message', args: [message(code: 'plan.label', default: 'Plan'), planInstance.id])
        redirect(action: "show", id: planInstance.id)
    }

    def delete(Long id) {
        def planInstance = Plan.get(id)
        if (!planInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'plan.label', default: 'Plan'), id])
            if(params.act) {
                redirect(action: 'list')
                return
            }
            render(([status:0] as JSON) as String )
            return
        }

        try {
            planInstance.delete(flush: true)
            planService.clearPlans()
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'plan.label', default: 'Plan'), id])
            if(params.act) {
                redirect(action: 'list')
                return
            }
            render(([status:1] as JSON) as String )
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'plan.label', default: 'Plan'), id])
            if(params.act) {
                redirect(action: 'list')
                return
            }
            render(([status:0] as JSON) as String )
        }
    }
}
