package com.baoming

import com.baoming.account.Role
import com.baoming.account.Student
import com.baoming.account.Teacher
import com.baoming.account.User
import org.apache.commons.io.FileUtils
import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils
import org.springframework.dao.DataIntegrityViolationException

class MediumController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def planService
    def provinceService
    def springSecurityService

    def index() {

        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        def userId = springSecurityService.authentication.principal?.id
        def name = params.name
        def list
        def total
        def year = params.date('year', 'yyyy')
        def cal = Calendar.instance
        def startDate
        def endDate
        if (!year) {
            cal.set(Calendar.DAY_OF_YEAR, 1)
            cal.set(Calendar.MONTH, 0)
            startDate = cal.time
            cal.add(Calendar.YEAR, 1)
            endDate = cal.time
        } else {
            cal.time = year
            cal.add(Calendar.YEAR, 1)
            startDate = year
            endDate = cal.time
        }

        def teacher
        if (SpringSecurityUtils.ifAllGranted(Role.AUTHORITY_TEACHER)) {
            teacher = Teacher.get(userId)
        } else {
            teacher = Teacher.get(params.long('teacherId'))
        }

        list = Medium.createCriteria().list(params) {
            if (teacher)
                eq('teacher', teacher)
            if (name) {
                like('name', "%${name}%")
            }
            ge('dateCreated', startDate)
            lt('dateCreated', endDate)
        }
        total = Medium.createCriteria().count {
            if (teacher)
                eq('teacher', teacher)
            if (name) {
                like('name', "%${name}%")
            }
            ge('dateCreated', startDate)
            lt('dateCreated', endDate)
        }

        [mediumInstanceList: list, mediumInstanceTotal: total]
    }

    def create() {
        [mediumInstance: new Medium(params),plans:planService.getMedPlans(),provinces:provinceService.getProvinces(),mediumPlans:planService.getMediumPlans()]
    }

    def save() {
        def mediumInstance = new Medium(params)

        def teacher
        def userId = springSecurityService.authentication.principal?.id
        if (SpringSecurityUtils.ifAllGranted(Role.AUTHORITY_TEACHER)) {
            teacher = Teacher.get(userId as Long)
        }else{
            if(params.teacherId){
                teacher = Teacher.get(params.long('teacherId'))
            }

            if(params.reviewStatus != Student.ReviewStatus.NO_AUDIT.name()){
                mediumInstance.reviewDate = new Date()
                mediumInstance.reviewPerson = User.get(userId as Long)
            }
        }
        mediumInstance.teacher = teacher

        mediumInstance.province = Province.findByCode(params.provinceId)
        mediumInstance.city = City.findByCode(params.cityId)
        mediumInstance.district = District.findByCode(params.districtId)

        mediumInstance.studentProvince = Province.findByCode(params.studentProvinceId)
        mediumInstance.studentCity = City.findByCode(params.studentCityId)
        mediumInstance.studentDistrict = District.findByCode(params.studentDistrictId)

        def file = request.getFile("voucherPathInp")
        if(file &&  !file.empty) {
            def cal = Calendar.instance
            def fileName1 = file.originalFilename
            def suffix1 = fileName1.substring(fileName1.lastIndexOf('.'))
            def storeName1 = "admission_ticket_${cal.timeInMillis}${suffix1}"
            def url1 = grailsApplication.config.baoming.image.storage.path
            def storageFilePath1 = url1 +'/'+storeName1
            def f1 = new File(storageFilePath1)
            if(!f1.exists()) {
                FileUtils.forceMkdir(f1)
            }
            file.transferTo(f1)
            mediumInstance.voucherPath = storeName1
        }

        if (!mediumInstance.save(flush: true)) {
            render(view: "create", model: [mediumInstance: mediumInstance,plans:planService.getMedPlans(),provinces:provinceService.getProvinces()])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'medium.label', default: 'Medium'), mediumInstance.id])
        redirect(action: "show", id: mediumInstance.id)
    }

    def show(Long id) {
        def mediumInstance = Medium.get(id)
        if (!mediumInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'medium.label', default: 'Medium'), id])
            redirect(action: "list")
            return
        }

        [mediumInstance: mediumInstance]
    }

    def edit(Long id) {
        def mediumInstance = Medium.get(id)
        if (!mediumInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'medium.label', default: 'Medium'), id])
            redirect(action: "list")
            return
        }

        [mediumInstance: mediumInstance,plans:planService.getMedPlans(),provinces:provinceService.getProvinces(),mediumPlans:planService.getMediumPlans()]
    }

    def update(Long id, Long version) {
        def mediumInstance = Medium.get(id)
        if (!mediumInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'medium.label', default: 'Medium'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (mediumInstance.version > version) {
                mediumInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'medium.label', default: 'Medium')] as Object[],
                        "Another user has updated this Medium while you were editing")
                render(view: "edit", model: [mediumInstance: mediumInstance,plans:planService.getMedPlans(),provinces:provinceService.getProvinces()])
                return
            }
        }

        mediumInstance.properties = params

        def teacher
        def userId = springSecurityService.authentication.principal?.id
        if (SpringSecurityUtils.ifAllGranted(Role.AUTHORITY_TEACHER)) {
            teacher = Teacher.get(userId as Long)
        }else{
            if(params.teacherId){
                teacher = Teacher.get(params.long('teacherId'))
            }

            if(params.reviewStatus != Student.ReviewStatus.NO_AUDIT.name()){
                mediumInstance.reviewDate = new Date()
                mediumInstance.reviewPerson = User.get(userId as Long)
            }
        }
        mediumInstance.teacher = teacher

        mediumInstance.province = Province.findByCode(params.provinceId)
        mediumInstance.city = City.findByCode(params.cityId)
        mediumInstance.district = District.findByCode(params.districtId)

        mediumInstance.studentProvince = Province.findByCode(params.studentProvinceId)
        mediumInstance.studentCity = City.findByCode(params.studentCityId)
        mediumInstance.studentDistrict = District.findByCode(params.studentDistrictId)

        def file = request.getFile("voucherPathInp")
        if(file &&  !file.empty) {
            def cal = Calendar.instance
            def fileName1 = file.originalFilename
            def suffix1 = fileName1.substring(fileName1.lastIndexOf('.'))
            def storeName1 = "admission_ticket_${cal.timeInMillis}${suffix1}"
            def url1 = grailsApplication.config.baoming.image.storage.path
            def storageFilePath1 = url1 +'/'+storeName1
            def f1 = new File(storageFilePath1)
            if(!f1.exists()) {
                FileUtils.forceMkdir(f1)
            }
            file.transferTo(f1)
            mediumInstance.voucherPath = storeName1
        }

        if (!mediumInstance.save(flush: true)) {
            render(view: "edit", model: [mediumInstance: mediumInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'medium.label', default: 'Medium'), mediumInstance.id])
        redirect(action: "show", id: mediumInstance.id)
    }

    def delete(Long id) {
        def mediumInstance = Medium.get(id)
        if (!mediumInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'medium.label', default: 'Medium'), id])
            redirect(action: "list")
            return
        }

        try {
            mediumInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'medium.label', default: 'Medium'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'medium.label', default: 'Medium'), id])
            redirect(action: "show", id: id)
        }
    }
}
