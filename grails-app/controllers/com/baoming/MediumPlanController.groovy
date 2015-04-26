package com.baoming

import grails.converters.JSON
import org.springframework.dao.DataIntegrityViolationException

class MediumPlanController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def planService

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [mediumPlanInstanceList: MediumPlan.list(params), mediumPlanInstanceTotal: MediumPlan.count()]
    }

    def create() {
        [mediumPlanInstance: new MediumPlan(params),plans:planService.getMediumPlanPlans()]
    }

    def save() {
        def mediumPlanInstance = new MediumPlan(params)
        if (!mediumPlanInstance.save(flush: true)) {
            render(view: "create", model: [mediumPlanInstance: mediumPlanInstance,plans:planService.getMediumPlanPlans()])
            return
        }
        def plans = params.list('plan')
        if(plans) {
            plans.each {p->
                def plan = Plan.get(p)
                MediumPlanDetail.create(mediumPlanInstance,plan)
            }
        }
        planService.clearMediumPlans()

        flash.message = message(code: 'default.created.message', args: [message(code: 'mediumPlan.label', default: 'MediumPlan'), mediumPlanInstance.id])
        redirect(action: "show", id: mediumPlanInstance.id)
    }

    def show(Long id) {
        def mediumPlanInstance = MediumPlan.get(id)
        if (!mediumPlanInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'mediumPlan.label', default: 'MediumPlan'), id])
            redirect(action: "list")
            return
        }

        [mediumPlanInstance: mediumPlanInstance]
    }

    def edit(Long id) {
        def mediumPlanInstance = MediumPlan.get(id)
        if (!mediumPlanInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'mediumPlan.label', default: 'MediumPlan'), id])
            redirect(action: "list")
            return
        }

        [mediumPlanInstance: mediumPlanInstance,plans:planService.getMediumPlanPlans()]
    }

    def update(Long id, Long version) {
        def mediumPlanInstance = MediumPlan.get(id)
        if (!mediumPlanInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'mediumPlan.label', default: 'MediumPlan'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (mediumPlanInstance.version > version) {
                mediumPlanInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'mediumPlan.label', default: 'MediumPlan')] as Object[],
                        "Another user has updated this MediumPlan while you were editing")
                render(view: "edit", model: [mediumPlanInstance: mediumPlanInstance,plans:planService.getMediumPlanPlans()])
                return
            }
        }

        mediumPlanInstance.properties = params

        if (!mediumPlanInstance.save(flush: true)) {
            render(view: "edit", model: [mediumPlanInstance: mediumPlanInstance,plans:planService.getMediumPlanPlans()])
            return
        }
        MediumPlanDetail.removeAll(mediumPlanInstance)
        def plans = params.list('plan')
        if(plans) {
            plans.each {p->
                def plan = Plan.get(p)
                MediumPlanDetail.create(mediumPlanInstance,plan)
            }
        }
        planService.clearMediumPlans()

        flash.message = message(code: 'default.updated.message', args: [message(code: 'mediumPlan.label', default: 'MediumPlan'), mediumPlanInstance.id])
        redirect(action: "show", id: mediumPlanInstance.id)
    }

    def delete(Long id) {
        def mediumPlanInstance = MediumPlan.get(id)
        if (!mediumPlanInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'mediumPlan.label', default: 'MediumPlan'), id])
            redirect(action: "list")
            return
        }

        try {
            mediumPlanInstance.delete(flush: true)
            planService.clearMediumPlans()
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'mediumPlan.label', default: 'MediumPlan'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'mediumPlan.label', default: 'MediumPlan'), id])
            redirect(action: "show", id: id)
        }
    }

    def getPlans(Long id) {
        def mediumPlanInstance = MediumPlan.get(id)
        if (!mediumPlanInstance) {
            render(([] as JSON) as String)
            return
        }
        def plans = planService.getMediumPlanList(mediumPlanInstance)
        if(!plans) {
            render(([] as JSON) as String)
            return
        }
        plans = plans.collect {
            [id:it.id,name:it.name]
        }
        render((plans as JSON) as String)
    }
}
