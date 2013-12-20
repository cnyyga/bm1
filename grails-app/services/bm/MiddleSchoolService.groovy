package bm

import com.baoming.MiddleSchool
import grails.plugin.cache.CacheEvict
import grails.plugin.cache.Cacheable

class MiddleSchoolService {

    @Cacheable('middleSchools')
    def getMiddleSchools(def districtId) {
        MiddleSchool.createCriteria().list {
            eq('district.id',districtId)
        }
    }

    @CacheEvict(value='middleSchools', allEntries = true)
    def clearMiddleSchools(def districtId){

    }
}
