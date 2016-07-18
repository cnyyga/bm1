package com.baoming

import org.springframework.dao.DataIntegrityViolationException
import grails.converters.JSON

class ProvinceController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
    def provinceService

    def index() {
        //render(view: 'index')
        redirect(action: "list", params: params)
    }

    def tree(){
        [provinces:Province.list([order: 'asc',sort: 'code'])]
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        def t = params.t
        def list
        def total
        def obj
        if (!t || t == 'province') {
            if(!params.status){
                params.status = 'ENABLED'
            }
            list = Province.createCriteria().list(params) {
                if(params.status){
                    eq('status',Province.Status."${params.status}")
                }
            }
            total =  Province.createCriteria().count{
                if(params.status){
                    eq('status',Province.Status."${params.status}")
                }
            }
        }
        if(t == 'city') {
            obj = Province.findByCode(params.id)
            list = City.findAllByProvince(obj,params)
            total =  City.countByProvince(obj)
        }
        if(t == 'district') {
            obj = City.findByCode(params.id)
            list = District.findAllByCity(obj,params)
            total =  District.countByCity(obj)
        }
        [instanceList: list, provinceInstanceTotal: total,obj:obj]
    }

    def create() {

        def instance
        if((!params.t || params.t == 'province') && params.id){
          //  instace = Province.findByCode(params.id)
        }
        if(params.t == 'city' && params.id){
            instance = Province.findByCode(params.id)
        }
        if(params.t == 'district' && params.id){
            instance = City.findByCode(params.id)
        }
        [code: params.id,t:params.t,instanceObj:instance]

    }

    def save() {
        def t = params.t
        def id = params.id
        def instance
        params.code = params.number
        if(t == 'city' && id)  {
            def province = Province.findByCode(id)
            if (!province)  {
                flash.message = message(code: 'default.save.failure.label')
                redirect(action: 'create',params: [t:t,id:id])
                return
            }
            instance = new City(params)
            instance.province = province
        }
        if(t == 'district' && id) {
            def city = City.findByCode(id)
            if (!city)  {
                flash.message = message(code: 'default.save.failure.label')
                redirect(action: 'create',params: [t:t,id:id])
                return
            }
            instance = new District(params)
            instance.city = city
        }
        if (!t || t == 'province') {
            instance = new Province(params)
        }
        if(!instance || !instance.save(flush: true)) {
            flash.message = message(code: 'default.save.failure.label')
            redirect(action: 'create',params: [t:t,id:id])
            return
        }
        if(t == 'city' && id)  {
            provinceService.clearCitys(id)
        }
        if(t == 'district' && id) {
            provinceService.clearDistricts(id)
        }
        if (!t || t == 'province') {
            provinceService.clearProvinces()
        }
        flash.message = message(code: 'default.created.message', args: [message(code: 'district.label', default: 'Student'), instance.code])
        redirect(action: 'list',params: [t:t,id:id])

    }

    def edit() {
        def t = params.t
        def id = params.id
        def pid = params.pid
        def pt = params.pt
        def instance
        def instanceObj
        if(!t || t == 'province') {
            instance = Province.findByCode(id)
        }
        if(t == 'city') {
            instance = City.findByCode(id)
            instanceObj = instance?.province
        }
        if(t == 'district') {
            instance = District.findByCode(id)
            instanceObj = instance?.city
        }
        if(!instance) {
            flash.message = message(code: 'default.save.failure.label')
            redirect(action: 'list',params: [t:t,id:pid])
            return
        }
        [instance:instance,instanceObj:instanceObj]

    }

    def update() {
        def instance
        def t = params.t
        def id = params.id
        def pid = params.pid //parentid
        def name = params.name
        def number = params.number
        def orderValue = params.orderValue?params.int('orderValue'):0
        if(!id || !name || !number) {
            flash.message = message(code: 'default.save.failure.label', args: [message(code: 'district.label', default: 'Student'), id])
            redirect(action: 'edit',params: [t:t,id:id,pid:pid])
            return
        }
        if(!t || t == 'province') {
            def province = Province.findByCode(id)
            if(!province) {
                flash.message = message(code: 'default.save.failure.label', args: [message(code: 'district.label', default: 'Student'), id])
                redirect(action: 'edit',params: [t:t,id:id,pid:pid])
                return
            }
            province.name = params.name
            province.number = params.number
            province.orderValue = orderValue
            province.status = Province.Status."${params.status}"
            if(!province.save()){
                flash.message = message(code: 'default.save.failure.label', args: [message(code: 'district.label', default: 'Student'), id])
                redirect(action: 'edit',params: [t:t,id:id,pid:pid])
                return
            }
            provinceService.clearProvinces()

        }
        if(t == 'city') {
            def city = City.findByCode(id)
            if(!city){
                flash.message = message(code: 'default.save.failure.label', args: [message(code: 'district.label', default: 'Student'), id])
                redirect(action: 'edit',params: [t:t,id:id,pid: pid,pt:'province'])
                return
            }
            instance = city.province
            city.name = params.name
            city.number = params.number
            city.orderValue = orderValue
            if(!city.save()) {
                flash.message = message(code: 'default.save.failure.label', args: [message(code: 'district.label', default: 'Student'), id])
                redirect(action: 'edit',params: [t:t,id:id,pid: pid,pt:'province'])
                return
            }
            provinceService.clearCitys(instance?.code)
        }
        if(t == 'district') {
            def district = District.findByCode(id)
            if(!district){
                flash.message = message(code: 'default.save.failure.label', args: [message(code: 'district.label', default: 'Student'), id])
                redirect(action: 'edit',params: [t:t,id:id,pid: pid,pt: 'city'])
                return
            }
            instance = district.city
            district.name = params.name
            district.number = params.number
            district.orderValue = orderValue
            if(!district.save()) {
                flash.message = message(code: 'default.save.failure.label', args: [message(code: 'district.label', default: 'Student'), id])
                redirect(action: 'edit',params: [t:t,id:id,pid: pid,pt: 'city'])
                return
            }
            provinceService.clearDistricts(instance?.code)
        }
        flash.message = message(code: 'default.updated.message', args: [message(code: 'district.label', default: 'Student'), id])
        redirect(action: 'list',params: [t:t,id:instance?.code])

    }

    def delete(Long id) {
        def instace
        def pid = params.pid
        if(!params.t || params.t == 'province'){
            instace = Province.findByCode(params.id)
        }
        if(params.t == 'city'){
            instace = City.findByCode(params.id)
        }
        if(params.t == 'district'){
            instace = District.findByCode(params.id)
        }

        if(!instace){
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'district.label', default: 'district'), id])
            //redirect(action: 'list',params: [t:params.t,id:pid])
            render(([status:0] as JSON) as String)
            return
        }

        try {
            instace.delete(flush: true)
            if(!params.t || params.t == 'province'){
                provinceService.clearProvinces()
            }
            if(params.t == 'city'){
                provinceService.clearCitys(params.id)
            }
            if(params.t == 'district'){
                provinceService.clearDistricts(params.id)
            }

            flash.message = message(code: 'default.deleted.message', args: [message(code: 'district.label', default: 'district'), id])
            //redirect(action: 'list',params: [t:params.t,id:pid])
            render(([status:1] as JSON) as String)
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'district.label', default: 'district'), id])
            //redirect(action: 'list',params: [t:params.t,id:pid])
            render(([status:0] as JSON) as String)
        }
    }
}
