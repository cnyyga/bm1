package com.baoming

import org.apache.commons.lang.builder.HashCodeBuilder

class MediumPlanDetail implements Serializable {

    MediumPlan mediumPlan
    Plan plan

    boolean equals(other) {
        if (!(other instanceof MediumPlanDetail)) {
            return false
        }

        other.mediumPlan?.id == mediumPlan?.id &&
                other.plan?.id == plan?.id
    }

    int hashCode() {
        def builder = new HashCodeBuilder()
        if (mediumPlan) builder.append(mediumPlan.id)
        if (plan) builder.append(plan.id)
        builder.toHashCode()
    }

    static MediumPlanDetail create(MediumPlan mediumPlan, Plan plan, boolean flush = false) {
        if(mediumPlan && mediumPlan.id && plan && plan.id)
            new MediumPlanDetail(mediumPlan: mediumPlan, plan: plan).save(flush: flush, insert: true)
    }

    static boolean remove(MediumPlan mediumPlan, Plan plan, boolean flush = false) {
        MediumPlanDetail instance = MediumPlanDetail.findByMediumPlanAndPlan(mediumPlan, plan)
        if (!instance) {
            return false
        }

        instance.delete(flush: flush)
        true
    }

    static void removeAll(MediumPlan mediumPlan) {
        executeUpdate 'DELETE FROM MediumPlanDetail WHERE mediumPlan=:mediumPlan', [mediumPlan: mediumPlan]
    }

    static constraints = {
    }

    static mapping = {
        id composite: ['mediumPlan','plan']
        version(false)
    }
}
