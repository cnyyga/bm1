package bm

import com.baoming.StudentType
import grails.plugin.cache.CacheEvict
import grails.plugin.cache.Cacheable

class StudentTypeService {

    @Cacheable('studentTypes')
    def getStudentTypes() {
        StudentType.listOrderByOrderValue(order: 'desc')
    }

    @CacheEvict(value='studentTypes', allEntries = true)
    def clearStudentTypes() {

    }
}
