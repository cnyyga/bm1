package bm

import com.baoming.City
import com.baoming.District
import com.baoming.Province
import grails.plugin.cache.CacheEvict
import grails.plugin.cache.Cacheable

class ProvinceService {

    @Cacheable('provinces')
    def getProvinces() {
        Province.listOrderByOrderValue(order: 'desc')
    }

    @CacheEvict(value='provinces', allEntries = true)
    def clearProvinces() {

    }

    @Cacheable('citys')
    def getCitys(def provinceId) {
        def w = City.where {
            province.id == provinceId
        }
        return w.list(sort: 'orderValue',order: 'desc')
    }

    @CacheEvict(value='citys', allEntries = true)
    def clearCitys(def provinceId) {

    }

    @Cacheable('districts')
    def getDistricts(def cityId) {
        def w = District.where {
            city.id == cityId
        }
        return w.list(sort: 'orderValue',order: 'desc')
    }

    @CacheEvict(value='districts', allEntries = true)
    def clearDistricts(def cityId) {

    }
}
