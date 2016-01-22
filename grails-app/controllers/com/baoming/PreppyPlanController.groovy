package com.baoming

import grails.converters.JSON
import org.springframework.dao.DataIntegrityViolationException

class PreppyPlanController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def planService

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [preppyPlanInstanceList: PreppyPlan.list(params), preppyPlanInstanceTotal: PreppyPlan.count()]
    }

    def create() {
        [preppyPlanInstance: new PreppyPlan(params),plans:planService.getPreppyPlanPlans()]
    }

    def save() {
        def preppyPlanInstance = new PreppyPlan(params)
        if (!preppyPlanInstance.save(flush: true)) {
            render(view: "create", model: [preppyPlanInstance: preppyPlanInstance,plans:planService.getPreppyPlanPlans()])
            return
        }
        def plans = params.list('plan')
        if(plans) {
            plans.each {p->
                def plan = Plan.get(p)
                PreppyPlanDetail.create(preppyPlanInstance,plan)
            }
        }
        planService.clearPreppyPlans();
        flash.message = message(code: 'default.created.message', args: [message(code: 'preppyPlan.label', default: 'PreppyPlan'), preppyPlanInstance.id])
        redirect(action: "show", id: preppyPlanInstance.id)
    }

    def show(Long id) {
        def preppyPlanInstance = PreppyPlan.get(id)
        if (!preppyPlanInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'preppyPlan.label', default: 'PreppyPlan'), id])
            redirect(action: "list")
            return
        }

        [preppyPlanInstance: preppyPlanInstance]
    }

    def edit(Long id) {
        def preppyPlanInstance = PreppyPlan.get(id)
        if (!preppyPlanInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'preppyPlan.label', default: 'PreppyPlan'), id])
            redirect(action: "list")
            return
        }

        [preppyPlanInstance: preppyPlanInstance,plans:planService.getPreppyPlanPlans()]
    }

    def update(Long id, Long version) {
        def preppyPlanInstance = PreppyPlan.get(id)
        if (!preppyPlanInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'preppyPlan.label', default: 'PreppyPlan'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (preppyPlanInstance.version > version) {
                preppyPlanInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'preppyPlan.label', default: 'PreppyPlan')] as Object[],
                        "Another user has updated this PreppyPlan while you were editing")
                render(view: "edit", model: [preppyPlanInstance: preppyPlanInstance,plans:planService.getPreppyPlanPlans()])
                return
            }
        }

        preppyPlanInstance.properties = params

        if (!preppyPlanInstance.save(flush: true)) {
            render(view: "edit", model: [preppyPlanInstance: preppyPlanInstance,plans:planService.getPreppyPlanPlans()])
            return
        }
        def plans = params.list('plan')
        PreppyPlanDetail.removeAll(preppyPlanInstance)
        if(plans) {
            plans.each {p->
                def plan = Plan.get(p)
                PreppyPlanDetail.create(preppyPlanInstance,plan)
            }
        }
        planService.clearPreppyPlans();
        flash.message = message(code: 'default.updated.message', args: [message(code: 'preppyPlan.label', default: 'PreppyPlan'), preppyPlanInstance.id])
        redirect(action: "show", id: preppyPlanInstance.id)
    }

    def delete(Long id) {
        def preppyPlanInstance = PreppyPlan.get(id)
        if (!preppyPlanInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'preppyPlan.label', default: 'PreppyPlan'), id])
            redirect(action: "list")
            return
        }

        try {
            preppyPlanInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'preppyPlan.label', default: 'PreppyPlan'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'preppyPlan.label', default: 'PreppyPlan'), id])
            redirect(action: "show", id: id)
        }
    }

    def getPlans(Long id) {
        def type = params.type
        if(!type) {
            render(([] as JSON) as String)
            return
        }
        def plans
        if(type != 'WG') {
            plans = planService.getPreppyPlanPlans() ;
        }else{
            def preppyPlanInstance = PreppyPlan.get(id)

            if (!preppyPlanInstance) {
                render(([] as JSON) as String)
                return
            }
            plans = planService.getPreppyPlanList(preppyPlanInstance)
        }

        if(!plans) {
            render(([] as JSON) as String)
            return
        }
        plans = plans.collect {
            [id:it.id,name:it.name]
        }
        render((plans as JSON) as String)
    }

    def getPlans1(Long id) {
        def type = params.type
        if(!type) {
            render(([] as JSON) as String)
            return
        }
        def plans = planService.getPlansByFlg(type);

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
