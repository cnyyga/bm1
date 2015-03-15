package bm

import com.baoming.MediumPlan
import com.baoming.Plan
import com.baoming.PlanUse
import com.baoming.PreppyPlan
import grails.plugin.cache.CacheEvict
import grails.plugin.cache.Cacheable

class PlanService {

    @Cacheable('plans')
    def getPlans(def flg) {
        if(!flg) {
            return Plan.findAllByStatus(Plan.Status.RUNNING,[sort:'orderValue',order:'desc'])
        }
        return Plan.createCriteria().list {
            planUses {
                eq('flg',flg)
            }
            eq('status',Plan.Status.RUNNING)
            order('orderValue','desc')
        }
    }

    def getStuPlans() {
        def plans = getPlans(PlanUse.USE_FLG_STU)
        if(!plans) {
            return   getPlans()
        }
        return plans
    }

    def getMedPlans() {
        return getPlans(PlanUse.USE_FLG_MED)
    }

    def getPgPlans() {
        return getPlans(PlanUse.USE_FLG_PUGAO)
    }

    def getZzPlans() {
        return getPlans(PlanUse.USE_FLG_ZHONG)
    }

    def getWsPlans() {
        return getPlans(PlanUse.USE_FLG_WAI)
    }

    @CacheEvict(value='plans', allEntries = true)
    def clearPlans() {

    }

    @Cacheable('medium_plans')
    def getMediumPlans() {
        MediumPlan.findAllByStatus(MediumPlan.Status.RUNNING)
    }

    @CacheEvict(value='medium_plans', allEntries = true)
    def clearMediumPlans() {

    }

    @Cacheable('preppy_plans')
    def getPreppyPlans() {
        PreppyPlan.findAllByStatus(PreppyPlan.Status.YES)
    }

    @CacheEvict(value='preppy_plans', allEntries = true)
    def clearPreppyPlans() {

    }
}
