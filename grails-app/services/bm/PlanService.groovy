package bm

import com.baoming.Plan
import grails.plugin.cache.CacheEvict
import grails.plugin.cache.Cacheable

class PlanService {

    @Cacheable('plans')
    def getPlans() {
        Plan.findAllByStatus(Plan.Status.RUNNING,[sort:'orderValue',order:'desc'])
    }

    @CacheEvict(value='plans', allEntries = true)
    def clearPlans() {

    }
}
