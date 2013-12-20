package bm

import com.baoming.Department
import grails.plugin.cache.CacheEvict
import grails.plugin.cache.Cacheable

class DepartmentService {

    @Cacheable('departments')
    def getDepartments() {
         Department.listOrderByOrderValue()
    }

    @CacheEvict(value='departments', allEntries = true)
    def clearDepartments() {

    }
}
