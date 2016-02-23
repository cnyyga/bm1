package bm

import com.baoming.MediumPlan
import com.baoming.MediumPlanDetail
import com.baoming.Plan
import com.baoming.PlanUse
import com.baoming.Preppy
import com.baoming.PreppyPlan
import com.baoming.PreppyPlanDetail
import grails.plugin.cache.CacheEvict
import grails.plugin.cache.Cacheable

class PlanService {

    @Cacheable('plans')
    def getPlans() {
            return Plan.findAllByStatus(Plan.Status.RUNNING,[sort:'orderValue',order:'desc'])
    }

    def getStuPlans() {
        def plans = Plan.createCriteria().list {
            eq("status",(Plan.Status.RUNNING))
            planUses {
                 eq("flg",PlanUse.USE_FLG_STU)
            }
        }
        if(!plans) {
            return getPlans()
        }
        return plans
    }

    def getMediumPlanList(MediumPlan mediumPlan){
        def plans = MediumPlanDetail.createCriteria().list {
            eq('mediumPlan',mediumPlan)
            projections {
                property('plan')
            }
        }
        if(!plans) {
            return
        }
        plans = plans.findAll {
            it.status.name() ==  Plan.Status.RUNNING.name()
        }.sort {p,p1->
            p1.orderValue-p.orderValue}
        return plans
    }

    def getMediumPlanPlans(){
        Plan.createCriteria().list {
            eq("status",(Plan.Status.RUNNING))
            planUses {
                eq("flg",PlanUse.USE_FLG_MED)
            }
        }
    }

    def getPreppyPlanPlans(){
        Plan.createCriteria().list {
            eq("status",(Plan.Status.RUNNING))
            planUses {
                gt("flg",PlanUse.USE_FLG_PREPPY)
            }
        }
    }

    def getPlansByFlg(flg){
        def sc = Preppy.StudentCateories.valueOf(flg)
        Plan.createCriteria().list {
            eq("status",(Plan.Status.RUNNING))
            planUses {
                eq("flg",sc.id as short)
            }
        }
    }

    def getPreppyPlanList(PreppyPlan preppyPlan){
        def plans = PreppyPlanDetail.createCriteria().list {
            eq("preppyPlan",preppyPlan)
            projections {
                property('plan')
            }
        }
        if(!plans) {
            return
        }
        plans = plans.findAll {
            it.status.name() ==  Plan.Status.RUNNING.name()
        }.sort {p,p1->
            p1.orderValue-p.orderValue}
        return plans
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
