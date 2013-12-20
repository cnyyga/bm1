package com.baoming

import org.springframework.dao.DataIntegrityViolationException
import grails.converters.JSON
import jxl.Workbook

class MiddleSchoolController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def downloadService
    def middleSchoolService

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        def districtId = params.districtId
        def name = params.name
        params.max = Math.min(max ?: 10, 100)
        def total = MiddleSchool.createCriteria().count {
            if(districtId){
                eq('district.code',districtId)
            }
            if(name) {
                or{
                    like('name',"%${name}%")
                    like('code',"%${name}%")
                    like('contact',"%${name}%")
                    like('tel',"%${name}%")
                }
            }
        }
        def list = MiddleSchool.createCriteria().list([offset: params.offset,max: params.max]) {
            if(districtId){
                eq('district.code',districtId)
            }
            if(name) {
                or{
                    like('name',"%${name}%")
                    like('code',"%${name}%")
                    like('contact',"%${name}%")
                    like('tel',"%${name}%")
                }
            }
        }
        [middleSchoolInstanceList: list, middleSchoolInstanceTotal: total]
    }

    def create() {
        [middleSchoolInstance: new MiddleSchool(params)]
    }

    def save() {
        def middleSchoolInstance = new MiddleSchool(params)
        def city = District.findByCode(params.districtId)
        middleSchoolInstance.district = city
        if (!middleSchoolInstance.save(flush: true)) {
            render(view: "create", model: [middleSchoolInstance: middleSchoolInstance])
            return
        }
        middleSchoolService.clearMiddleSchools(params.districtId)
        flash.message = message(code: 'default.created.message', args: [message(code: 'middleSchool.label', default: 'MiddleSchool'), middleSchoolInstance.id])
        redirect(action: "show", id: middleSchoolInstance.id)
    }

    def show(Long id) {
        def middleSchoolInstance = MiddleSchool.get(id)
        if (!middleSchoolInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'middleSchool.label', default: 'MiddleSchool'), id])
            redirect(action: "list")
            return
        }

        [middleSchoolInstance: middleSchoolInstance]
    }

    def edit(Long id) {
        def middleSchoolInstance = MiddleSchool.get(id)
        if (!middleSchoolInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'middleSchool.label', default: 'MiddleSchool'), id])
            redirect(action: "list")
            return
        }

        [middleSchoolInstance: middleSchoolInstance]
    }

    def update(Long id, Long version) {
        def middleSchoolInstance = MiddleSchool.get(id)
        if (!middleSchoolInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'middleSchool.label', default: 'MiddleSchool'), id])
            redirect(action: "list")
            return
        }

        middleSchoolInstance.properties = params
        def city = District.findByCode(params.districtId)
        middleSchoolInstance.district = city
        if (!middleSchoolInstance.save(flush: true)) {
            render(view: "edit", model: [middleSchoolInstance: middleSchoolInstance])
            return
        }
        middleSchoolService.clearMiddleSchools(params.districtId)
        flash.message = message(code: 'default.updated.message', args: [message(code: 'middleSchool.label', default: 'MiddleSchool'), middleSchoolInstance.id])
        redirect(action: "show", id: middleSchoolInstance.id)
    }

    def delete(Long id) {
        def middleSchoolInstance = MiddleSchool.get(id)
        if (!middleSchoolInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'middleSchool.label', default: 'MiddleSchool'), id])
            if(params.act) {
                redirect(action: 'list')
                return
            }
            render(([status:0] as JSON) as String )
            return
        }

        try {
            def district = middleSchoolInstance.district
            middleSchoolInstance.delete(flush: true)
            middleSchoolService.clearMiddleSchools(district?.id)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'middleSchool.label', default: 'MiddleSchool'), id])
            if(params.act) {
                redirect(action: 'list')
                return
            }
            render(([status:1] as JSON) as String )
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'middleSchool.label', default: 'MiddleSchool'), id])
            if(params.act) {
                redirect(action: 'list')
                return
            }
            render(([status:0] as JSON) as String )
        }
    }

    def importFile() {

        if (!params.u) {
            render(view: 'import',model: [status: '0'])
            return
        }
        def file = request.getFile("file")
        if (!file || file.empty) {
            render(view: 'import',model: [status: '2'])
            return
        }

        def list = downloadService.getExcelToList(file.inputStream)
        if(!list) {
            render(view: 'import',model: [status: '2'])
            return
        }
        def r = downloadService.saveMiddleSchoolFromList(list)
        render(view: 'import',model: [status: '1']+r)
    }
}
