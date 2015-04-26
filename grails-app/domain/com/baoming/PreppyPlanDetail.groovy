package com.baoming

import org.apache.commons.lang.builder.HashCodeBuilder

class PreppyPlanDetail implements Serializable {

    PreppyPlan preppyPlan
    Plan plan

    boolean equals(other) {
        if (!(other instanceof PreppyPlanDetail)) {
            return false
        }

        other.preppyPlan?.id == preppyPlan?.id &&
                other.plan?.id == plan?.id
    }

    int hashCode() {
        def builder = new HashCodeBuilder()
        if (preppyPlan) builder.append(preppyPlan.id)
        if (plan) builder.append(plan.id)
        builder.toHashCode()
    }

    static PreppyPlanDetail create(PreppyPlan preppyPlan, Plan plan, boolean flush = false) {
        if(preppyPlan && preppyPlan.id && plan && plan.id)
            new PreppyPlanDetail(preppyPlan: preppyPlan, plan: plan).save(flush: flush, insert: true)
    }

    static boolean remove(PreppyPlan preppyPlan, Plan plan, boolean flush = false) {
        PreppyPlanDetail instance = PreppyPlanDetail.findByPreppyPlanAndPlan(preppyPlan, plan)
        if (!instance) {
            return false
        }

        instance.delete(flush: flush)
        true
    }

    static void removeAll(PreppyPlan preppyPlan) {
        executeUpdate 'DELETE FROM PreppyPlanDetail WHERE preppyPlan=:preppyPlan', [preppyPlan: preppyPlan]
    }

    static constraints = {
    }

    static mapping = {
        id composite: ['preppyPlan','plan']
        version(false)
    }
}
